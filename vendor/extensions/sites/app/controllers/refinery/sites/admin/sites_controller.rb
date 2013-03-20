module Refinery
  module Sites
    module Admin
      class SitesController < ::Refinery::AdminController

        crudify :'refinery/sites/site',
                :title_attribute => 'name',
                :xhr_paging => true

 #       before_filter :reset_current_site_id, :except => [:create, :update]
        before_filter :pre_index, :only => :index

				def new
          @site = Site.new

          # Creating a unique temporary site_id
          session[:current_site] = (rand * 50000 + 50000)

          @site.name = "New site"
          session[:current_site_name] = @site.name

          @site.has_calendars = false
          @site.calendar_mode = "WEEK"
          @site.calendar_height = 500

          @site.has_products = false
          @site.has_services = true
          @site.has_coupons = false
          @site.has_blog = false
          @site.has_events = false

          @site.flags_position = "right"
          @site.flags_border = "#000000"

          @site.build_design

          @site.design.scss_model = "Classic"
          @site.design.font_family = 'Calibri'
          @site.design.menu_style = '1em #000000 bold'
          @site.design.p_style = '1.1em #000000 normal'
          @site.design.h1_style = '1.8em #000000 bold'
          @site.design.h2_style = '1.6em #000000 bold'
          @site.design.h3_style = '1.3em #000000 bold'
          @site.design.table_caption_style = '1.2em #000000 bold'
          @site.design.table_row_style = '1em #000000 normal'
          @site.design.table_border_style = '1px #000000 solid'
          @site.design.background_color = '#606060'
          @site.design.foreground_color = '#FFFFFF'
          @site.design.menu_color = '#A0A0A0'

          @site.build_home_page
          @site.build_aboutus_page
          @site.build_services_page

        end

        def edit
	        session[:current_site] = @site.id
          session[:current_site_name] = @site.name
        end

        def after_create
	        update_site_id_in_resources
          session[:current_site] = @site.id
          session[:current_site_name] = @site.name
        end


        def update
          if params[:preview].present?
            preview
          elsif @site.update_attributes(params[:site])
            flash.notice = t('refinery.crudify.updated', :what => 'The site ' + @site.name)
            session[:current_site_name] = @site.name
            redirect_to refinery.edit_sites_admin_site_path(@site)
          else
            unless request.xhr?
              render :action => 'edit'
            else
              render :partial => '/refinery/admin/error_messages', :locals => {
                  :object => @Site, :include_object_name => true
              }
            end
          end
        end

        PARTIAL_PAGES = ["products","coupons","mediagallery","blog","events","contact"]

        def preview
          @slug = params[:id].to_s
          @site = Site.find(params[:id])
          @site.attributes.each do |attr, val|
            @site.send("#{attr}=", params[:site][attr.to_sym]) if params[:site].has_key?(attr.to_sym)
          end

          @site_id = @site.id.to_s

          @site.design.attributes = params[:site][:design_attributes]
          @site.home_page.attributes = params[:site][:home_page_attributes]
          @site.aboutus_page.attributes = params[:site][:aboutus_page_attributes]
          @site.services_page.attributes = params[:site][:services_page_attributes]

          params[:site][:gallery_images_attributes].each do |id, image_attributes|
            attrs = image_attributes.delete_if{|k, v| v.blank?}
            @site.gallery_images.build(attrs) unless attrs.empty?
          end

          params[:site][:flowing_images_attributes].each do |id, image_attributes|
            attrs = image_attributes.delete_if{|k, v| v.blank?}
            @site.flowing_images.build(attrs) unless attrs.empty?
          end

          ["product", "about", "service"].each do |page|
            params[:site]["#{page}_flowing_images_attributes".to_sym].each do |id, image_attributes|
              attrs = image_attributes.delete_if{|k, v| v.blank?}
              @site.send("#{page}_flowing_images".to_sym).build(attrs) unless attrs.empty?
            end
          end

          params[:site][:slide_images_attributes].each do |id, image_attributes|
            attrs = image_attributes.delete_if{|k, v| v.blank?}
            @site.slide_images.build(attrs) unless attrs.empty?
          end

          ["product", "about", "service"].each do |page|
            params[:site]["#{page}_slide_images_attributes".to_sym].each do |id, image_attributes|
              attrs = image_attributes.delete_if{|k, v| v.blank?}
              @site.send("#{page}_slide_images".to_sym).build(attrs) unless attrs.empty?
            end
          end

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

          if !PARTIAL_PAGES.include?(@selected_menu) then
            eval %(@#{@selected_menu}_page = #{class_name}.find_by_site_id(#{@site_id}))
            @requested_page = eval %('/refinery/sites/#{@selected_menu}_pages/show')
          else
            @requested_page = eval %('/refinery/sites/sites/_#{@selected_menu}')
          end
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

        def pre_index
          if (session[:current_site].present? && (session[:current_site] != -1))
            @site = Site.find(session[:current_site])
            session[:current_site_name] = @site.name
            redirect_to refinery.edit_sites_admin_site_path(@site)
          end
        end

        def close
          no_site_selected
          redirect_to refinery.sites_admin_sites_path
        end

        def no_site_selected
          if current_refinery_user.site_id.nil?
            session[:current_site] = -1
            session[:current_site_name] = 'No site selected'
          end
        end

	      def update_site_id_in_resources
		      # Replacing the temporary site_id with the actual site_if for all new images
		      ::Refinery::Image.where(:site_id => session[:current_site]).each do |image|
			      image.site_id = @site.id
			      image.save
		      end

          # Replacing the temporary site_id with the actual site_if for all new resources
          ::Refinery::Resource.where(:site_id => session[:current_site]).each do |resource|
            resource.site_id = @site.id
            resource.save
          end

        end

        def delete_resources
          # Replacing the temporary site_id with the actual site_if for all new images
          ::Refinery::Image.where(:site_id => session[:current_site]).each do |image|
            image.delete!
          end

          # Replacing the temporary site_id with the actual site_if for all new resources
          ::Refinery::Resource.where(:site_id => session[:current_site]).each do |resource|
            resource.site_id = @site.id
            resource.save
          end

        end

      end
    end
  end
end
