module Refinery
  module Sites
    class ProductCategoriesController < ::ApplicationController

      before_filter :find_all_product_categories
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product_category in the line below:
        present(@page)
      end

      def show
        @product_category = ProductCategory.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product_category in the line below:
        present(@page)
      end

    protected

      def find_all_product_categories
        @product_categories = ProductCategory.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/product_categories").first
      end

    end
  end
end
