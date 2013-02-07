module Refinery
  module Sites
    module Admin
      class DesignsController < ::Refinery::AdminController

        crudify :'refinery/sites/design',
                :title_attribute => 'scss_model', :xhr_paging => true

      end
    end
  end
end
