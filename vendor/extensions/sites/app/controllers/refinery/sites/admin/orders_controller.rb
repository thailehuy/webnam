module Refinery
  module Sites
    module Admin
      class OrdersController < ::Refinery::AdminController

        crudify :order, :xhr_paging => true

      end
    end
  end
end
