module Refinery
  module Admin
    class ImagesController < ::Refinery::AdminController

      crudify :'refinery/image',
              :order => "created_at DESC",
              :sortable => false,
              :xhr_paging => true

      before_filter :change_list_mode_if_specified, :init_dialog

      # webnam
      def find_all_images(conditions='')
        @images = Image.where(conditions).where({:site_id => session[:current_site]}).order("created_at DESC")
      end

      def new
        @image = ::Refinery::Image.new if @image.nil?

        @url_override = refinery.admin_images_path(:dialog => from_dialog?)
      end

      # This renders the image insert dialog
      def insert
        self.new if @image.nil?

        @url_override = refinery.admin_images_path(request.query_parameters.merge(:insert => true))

        if params[:conditions].present?
          extra_condition = params[:conditions].split(',')

          extra_condition[1] = true if extra_condition[1] == "true"
          extra_condition[1] = false if extra_condition[1] == "false"
          extra_condition[1] = nil if extra_condition[1] == "nil"
        end

        find_all_images(({extra_condition[0].to_sym => extra_condition[1]} if extra_condition.present?))
        search_all_images if searching?

        paginate_images

        render :action => "insert"
      end

      def create
        @images = []
        begin
          unless params[:image].present? and params[:image][:image].is_a?(Array)
            # webnam
            @images << (@image = ::Refinery::Image.create(params[:image],
                                                          :site_id => session[:current_site]))
          else
            params[:image][:image].each do |image|
              # webnam
              @images << (@image = ::Refinery::Image.create(:image => image,
                                                            :site_id => session[:current_site]))
            end
          end
        rescue Dragonfly::FunctionManager::UnableToHandle
          logger.warn($!.message)
          @image = ::Refinery::Image.new
        end

        unless params[:insert]
          if @images.all?(&:valid?)
            flash.notice = t('created', :scope => 'refinery.crudify', :what => "'#{@images.map(&:title).join("', '")}'")
            if from_dialog?
              @dialog_successful = true
              render :nothing => true, :layout => true
            else
              redirect_to refinery.admin_images_path
            end
          else
            self.new # important for dialogs
            render :action => 'new'
          end
        else
          # if all uploaded images are ok redirect page back to dialog, else show current page with error
          if @images.all?(&:valid?)
            @image_id = @image.id if @image.persisted?
            @image = nil

            self.insert
          end
        end
      end

    protected

      def init_dialog
        @app_dialog = params[:app_dialog].present?
        @field = params[:field]
        @update_image = params[:update_image]
        @thumbnail = params[:thumbnail]
        @callback = params[:callback]
        @conditions = params[:conditions]
      end

      def change_list_mode_if_specified
        if action_name == 'index' && params[:view].present? && Refinery::Images.image_views.include?(params[:view].to_sym)
           Refinery::Images.preferred_image_view = params[:view]
        end
      end

      def paginate_images
        @images = @images.paginate(:page => params[:page], :per_page => Image.per_page(from_dialog?, !@app_dialog))
      end

      def restrict_controller
        super unless action_name == 'insert'
      end

      def store_current_location!
        super unless action_name == 'insert' or from_dialog?
      end

    end
  end
end
