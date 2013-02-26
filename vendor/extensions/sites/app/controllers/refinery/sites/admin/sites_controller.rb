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
          session[:current_site] = (DateTime.now.to_f*100).to_i-133224063670

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
          if @site.update_attributes(params[:site])
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
