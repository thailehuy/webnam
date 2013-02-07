module Refinery
  module Sites
    module Admin
      class GoogleCalendarsController < ::Refinery::AdminController

        crudify :'refinery/sites/google_calendar',
                :title_attribute => 'account',
                :xhr_paging => true,
                :sortable => false

        def find_all_google_calendars(conditions='')
          if @editing_site
            @google_calendars = GoogleCalendar.where(conditions).where({:site_id => session[:current_site]}).order("account")
          else
            @google_calendars = GoogleCalendar.where(conditions).order("account")
          end
        end

        def new
          @google_calendar = GoogleCalendar.new
          @google_calendar.site_id = session[:current_site]
        end

      end
    end
  end
end
