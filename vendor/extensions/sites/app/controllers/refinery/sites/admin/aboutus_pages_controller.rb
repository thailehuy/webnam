module Refinery
  module Sites
    module Admin
      class AboutusPagesController < ::Refinery::AdminController

        crudify :'refinery/sites/aboutus_page',
                :title_attribute => 'category', :xhr_paging => true

      end
    end
  end
end
