require 'acts_as_indexed'

module Refinery
  module Sites
    class BlogPost < Refinery::Core::BaseModel
      
      translates :title, :content
      acts_as_indexed :fields => [:title, :content]

      attr_accessible :site_id, :title, :content, :published
      validates :title, :presence => true

      belongs_to :site, :class_name => '::Refinery::Sites::Site'

      def search_title
        'blog'
      end

    end
  end
end
