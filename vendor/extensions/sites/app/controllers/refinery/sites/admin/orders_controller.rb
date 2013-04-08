module Refinery
  module Sites
    module Admin
      class OrdersController < ::Refinery::AdminController

        crudify :'refinery/sites/order', :xhr_paging => true

        def index
          @site = Site.find(session[:current_site])
          @orders = @site.orders.paginate(page: params[:page], per_page: 50)
        end

      end
    end
  end
end
