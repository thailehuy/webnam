module Refinery
  module Sites
    class GoogleCalendarsController < ::ApplicationController

      before_filter :find_all_google_calendars
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @google_calendar in the line below:
        present(@page)
      end

      def show
        @google_calendar = GoogleCalendar.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @google_calendar in the line below:
        present(@page)
      end

    protected

      def find_all_google_calendars
        @google_calendars = GoogleCalendar.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/google_calendars").first
      end

    end
  end
end
