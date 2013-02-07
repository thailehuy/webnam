module Refinery
  module Sites
    class AboutusPagesController < ::ApplicationController

      before_filter :find_all_aboutus_pages
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @aboutus_page in the line below:
        present(@page)
      end

      def show
        @aboutus_page = AboutusPage.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @aboutus_page in the line below:
        present(@page)
      end

    protected

      def find_all_aboutus_pages
        @aboutus_pages = AboutusPage.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/aboutus_pages").first
      end

    end
  end
end
