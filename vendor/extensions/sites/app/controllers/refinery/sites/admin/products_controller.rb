module Refinery
  module Sites
    module Admin
      class ProductsController < ::Refinery::AdminController

        crudify :'refinery/sites/product',
                :title_attribute => 'name', :xhr_paging => true

        before_filter :find_site

        def find_all_products(conditions='')

          @category = params[:category].nil? ? 0 : params[:category].to_i
          @gender = params[:gender].nil? ? 0 : params[:gender].to_i
          @products = Product.where(
              @gender == 0 ? '' : {:gender => @gender}).where(
              @category == 0 ? '' : {:product_category_id => @category}).where(
              {:site_id => session[:current_site]}).where(conditions).order("position")
        end

        def new
          @product = Product.new
          @product.site_id = session[:current_site]
          @product.product_category_id = 0
        end

        def find_site
          @site = Site.find(session[:current_site])
        end

      end
    end
  end
end
