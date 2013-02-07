require 'acts_as_indexed'

module Refinery
  module Sites
    class Event < Refinery::Core::BaseModel
      
      translates :event_title, :event_summary
      acts_as_indexed :fields => [:event_title, :event_summary]

      belongs_to :site, :class_name => '::Refinery::Sites::Site'

      attr_accessible :site_id, :event_title, :event_summary, :event_date, :published


      validates :event_title, :presence => true

      def search_title
        'events'
      end
    end
  end
end
