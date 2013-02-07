module Refinery
  module Sites
    class HomePagesController < ::ApplicationController

      before_filter :find_all_home_pages
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @home_page in the line below:
        present(@page)
      end

      def show
        @home_page = HomePage.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @home_page in the line below:
        present(@page)
      end

    protected

      def find_all_home_pages
        @home_pages = HomePage.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/home_pages").first
      end

    end
  end
end
