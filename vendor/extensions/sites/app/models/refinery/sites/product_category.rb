require 'acts_as_indexed'

module Refinery
  module Sites
    class ProductCategory < Refinery::Core::BaseModel
      
      translates :name
      acts_as_indexed :fields => [:name]

      attr_accessible :site_id, :name, :position


      validates :name, :presence => true

      belongs_to :site, :class_name => '::Refinery::Sites::Site'

      def search_title
        'products'
      end

    end
  end
end
