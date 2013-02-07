require 'mailer'
require 'search_engine'
require 'time'

module Refinery
  module Sites
    class SitesController < ::ApplicationController

      PARTIAL_PAGES = ["products","coupons","mediagallery","blog","events","contact"]

      before_filter :find_all_sites
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @site in the line below:
        present(@page)
      end

      def prepare_show

        begin
          @slug = params[:id].to_s
          @site = Site.find(params[:id])
          @site_id = @site.id.to_s

          @menu_items = Refinery::Sites::Site::SITE_PAGES
#          @menu_items = Refinery::Sites::Site::SITE_PAGES.drop(@site.logo.nil? ? 0:1)
          @menu_items -= ["services"] unless @site.has_services
          @menu_items -= ["products"] unless @site.has_products
          @menu_items -= ["mediagallery"] unless @site.has_gallery
          @menu_items -= ["coupons"] unless @site.has_coupons
          @menu_items -= ["blog"] unless @site.has_blog
          @menu_items -= ["events"] unless @site.has_events

          @menu_padding = (8 - @menu_items.count)*3 - 3

        rescue
          redirect_to '/'
          false
        end

      end

      def show

        if prepare_show
          @selected_menu = params[:page] || session[('site' + @site.id.to_s).to_sym] || 'home'
          @selected_menu = 'home' unless ((Refinery::Sites::Site::SITE_PAGES.include? @selected_menu) || (@selected_menu == 'contact'))
          session[('site' + @site.id.to_s).to_sym] = @selected_menu
          class_name = @selected_menu.to_s.camelize+"Page"

          if !PARTIAL_PAGES.include?(@selected_menu) then
            eval %(@#{@selected_menu}_page = #{class_name}.find_by_site_id(#{@site_id}))
            @requested_page = eval %('/refinery/sites/#{@selected_menu}_pages/show')
          else
            @requested_page = eval %('/refinery/sites/sites/_#{@selected_menu}')
          end

          case @selected_menu
            when 'home'
              if @site.has_calendars then
                @calendar_height =  @site.calendar_height.to_s
                @calendar_url = "https://www.google.com/calendar/embed?showTitle=0&showNav=1&showDate=1&showPrint=0&showCalendars=0&showTz=0"
                @calendar_url += "&mode=" + @site.calendar_mode + "&height=" + @calendar_height + "&wkst=2&bgcolor=%23FFFFFF"
                @site.google_calendars.order('account').each do |calendar|
                  @calendar_url += "&src=" + calendar.account + '&color=%23' + calendar.bg_color[1..-1]
                end
                @calendar_url += "&ctz=Asia/Saigon"
              end

              if !@home_page.splash.nil? && @home_page.splash.width != 800
                @splash_height = (800 * @home_page.splash.height / @home_page.splash.width).floor
              end

            when 'products'
              prepare_products

            when 'contact'
              @new_message = true
          end

          # you can use meta fields from your model instead (e.g. browser_title)
          # by swapping @page for @site in the line below:
          present(@site)

        end
      end

      def search
        if prepare_show
          @selected_menu = 'search_results'
          @requested_page = eval %('/refinery/sites/sites/_#{@selected_menu}')

          @results = SearchEngine.search(params[:query], params[:page])

          render :action => :show
        end
      end

      def message

        if prepare_show

          @selected_menu = 'contact'
          @requested_page = eval %('/refinery/sites/sites/_#{@selected_menu}')
          @new_message = false

          if (cookies[:last_request_date].nil? ||
              (Time.now.to_i - (cookies[:last_request_date].to_i) > ::MINIMUM_SECONDS_BETWEEN_REQUESTS))

            name = params[:name]
            message = params[:message]
            email = params[:email]
            phone = params[:phone]

            unless name.blank? || email.blank?

              WebnamMailer.notify_inquiry_received(@site.name, email,
                                                   t('inquiry_notif_subject'),
                                                   t('inquiry_notif_body',
                                                     :inquirer => name,
                                                     :site_name => @site.name))

              begin
                WebnamMailer.notify_owner_of_inquiry(@site.name, name, email, message, phone,
                                                     @site.contact_email)

                cookies[:last_request_date] = Time.now.to_i

                @message_feedback = t('send_ok')

              rescue => detail
                logger.error detail.backtrace.join("\n")
                @message_feedback = t('send_nok')
              end

            else
              @message_feedback = t('send_nok')
            end

          else
            @message_feedback = t('send_too_many')
            logger.info "Too many contact requests from the same person!"
            logger.info "last_request_date = " + (Time.now.to_i - cookies[:last_printed_coupon_date].to_i).to_s unless cookies[:last_printed_coupon_date].nil?
          end

          render :action => :show
        end
      end

      def prepare_products
        @category = params[:category].nil? ? 0 : params[:category].to_i
        @gender = params[:gender].nil? ? 0 : params[:gender].to_i
        @products = Product.where(
            @gender == 0 ? '' : {:gender => @gender}).where(
            @category == 0 ? '' : {:product_category_id => @category}).where(
            {:site_id => @site_id}).order("position")

        @categories = ProductCategory.where(
            {:site_id => @site_id}).order("position").all.map {
            |category| [category.name, category.id]}

        @genders = Product.gender_list.map{|name,index| [t(name),index]}
      end

      def coupon_create
        @coupon = Coupon.find(params[:coupon])
        nb_existing_coupons = @coupon.printed_coupons.count

        if (cookies[:last_printed_coupon_date].nil? ||
            (Time.now.to_i - (cookies[:last_printed_coupon_date].to_i) > ::MINIMUM_SECONDS_BETWEEN_COUPONS))

          if (@coupon.max_number > nb_existing_coupons)
            @printed_coupon = @coupon.printed_coupons.build
            @printed_coupon.coupon_number = @coupon.seed_number + nb_existing_coupons

            @printed_coupon.email_address = 'some email address'
            @printed_coupon.save!
            cookies[:last_printed_coupon_date] = Time.now.to_i
          end

          if (@coupon.max_number <= (nb_existing_coupons+1))
            @coupon.no_coupons_left = true
            if @coupon.hide_when_finished
              @coupon.displayed = false
            end
            @coupon.save!
          end

        else
          logger.info "Too many coupons for the same person!"
          logger.info "last_printed_coupon_date = " + (Time.now.to_i - cookies[:last_printed_coupon_date].to_i).to_s unless cookies[:last_printed_coupon_date].nil?
        end


        respond_to do |format|
          format.js {
            render :action => :show
          }
        end
      end

    protected

      def find_all_sites
        @sites = Site.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/sites").first
      end

    end
  end
end
