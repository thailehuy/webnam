module Refinery
  module Sites
    module Admin
      class EventsController < ::Refinery::AdminController

        crudify :'refinery/sites/event',
                :title_attribute => 'event_title', :xhr_paging => true,
                :sortable => false

        def find_all_events(conditions='')
          if @editing_site
            @events = Event.where(conditions).where({:site_id => session[:current_site]}).order("event_date desc")
          else
            @events = Event.where(conditions).order("event_date desc")
          end
        end

        def new
          @event = Event.new
          @event.site_id = session[:current_site]
        end

      end
    end
  end
end
