require 'acts_as_indexed'

module Refinery
  module Sites
    class GoogleCalendar < Refinery::Core::BaseModel
      
      attr_accessible :account, :bg_color, :site_id

      validates :account, :presence => true

      belongs_to :site, :class_name => '::Refinery::Sites::Site'
    
    end
  end
end
