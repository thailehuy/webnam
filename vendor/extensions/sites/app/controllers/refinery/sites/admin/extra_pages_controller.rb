module Refinery
  module Sites
    module Admin
      class ExtraPagesController < ::Refinery::AdminController

        crudify :'refinery/sites/extra_page', :xhr_paging => true

        def new
          @extra_page = ExtraPage.new
          @extra_page.site_id = session[:current_site]
        end

        def preview
          @site = Site.find(session[:current_site])
          extra = @site.extra_pages.build(params[:extra_page])
          @slug = params[:id].to_s

          @site_id = @site.id.to_s

          @menu_items = Refinery::Sites::Site::SITE_PAGES
          @menu_items -= ["services"] unless @site.has_services
          @menu_items -= ["products"] unless @site.has_products
          @menu_items -= ["mediagallery"] unless @site.has_gallery
          @menu_items -= ["coupons"] unless @site.has_coupons
          @menu_items -= ["blog"] unless @site.has_blog
          @menu_items -= ["events"] unless @site.has_events

          @menu_padding = (8 - @menu_items.count)*3 - 3

          @selected_menu = params[:preview]
          @selected_menu = 'home' unless ((Refinery::Sites::Site::SITE_PAGES.include? @selected_menu) || (@selected_menu == 'contact'))
          class_name = @selected_menu.to_s.camelize+"Page"

          @requested_page = '/refinery/sites/extra_pages/show'

          @extra_page = extra
          @selected_menu = extra.parent_page
          @selected_menu = extra.url if @selected_menu.blank?

          @services_page = @site.services_page
          @home_page = @site.home_page
          @aboutus_page = @site.aboutus_page

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
              @category = params[:category].nil? ? 0 : params[:category].to_i
              @gender = params[:gender].nil? ? 0 : params[:gender].to_i
              @products = Product.where(
                  @gender == 0 ? '' : {:gender => @gender}).where(
                  @category == 0 ? '' : {:product_category_id => @category}).where(
                  {:site_id => @site_id}).order("position").paginate(:page => params[:page_count], :per_page => @site.products_per_page)

              @categories = ProductCategory.where(
                  {:site_id => @site_id}).order("position").all.map {
                  |category| [category.name, category.id]}

              @genders = Product.gender_list.map{|name,index| [t(name),index]}

            when 'contact'
              @new_message = true
          end
          @admin_preview = true
          present(@site)

          render "/refinery/sites/sites/show", layout: 'application'
        end

      end
    end
  end
end
