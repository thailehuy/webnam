module Refinery
  module Sites
    module Admin
      class ProductCategoriesController < ::Refinery::AdminController

        crudify :'refinery/sites/product_category',
                :title_attribute => 'name', :xhr_paging => true

        def find_all_product_categories(conditions='')
          if @editing_site
            @product_categories = ProductCategory.where(conditions).where({:site_id => session[:current_site]}).order("position")
          else
            @product_categories = ProductCategory.where(conditions).order("position")
          end
        end

        def new
          @product_category = ProductCategory.new
          @product_category.site_id = session[:current_site]
        end

      end
    end
  end
end
