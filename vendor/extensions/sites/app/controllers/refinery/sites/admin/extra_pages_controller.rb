module Refinery
  module Sites
    module Admin
      class ExtraPagesController < ::Refinery::AdminController

        crudify :'refinery/sites/extra_page', :xhr_paging => true

        def new
          @extra_page = ExtraPage.new
          @extra_page.site_id = session[:current_site]
        end

      end
    end
  end
end
