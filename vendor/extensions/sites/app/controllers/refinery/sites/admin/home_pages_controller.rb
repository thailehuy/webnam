module Refinery
  module Sites
    module Admin
      class HomePagesController < ::Refinery::AdminController

        crudify :'refinery/sites/home_page', :xhr_paging => true

      end
    end
  end
end
