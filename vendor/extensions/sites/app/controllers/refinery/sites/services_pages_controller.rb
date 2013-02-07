module Refinery
  module Sites
    class ServicesPagesController < ::ApplicationController

      before_filter :find_all_services_pages
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @services_page in the line below:
        present(@page)
      end

      def show
        @services_page = ServicesPage.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @services_page in the line below:
        present(@page)
      end

    protected

      def find_all_services_pages
        @services_pages = ServicesPage.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/services_pages").first
      end

    end
  end
end
