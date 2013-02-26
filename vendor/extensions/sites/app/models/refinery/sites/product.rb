require 'acts_as_indexed'

module Refinery
  module Sites
    class Product < Refinery::Core::BaseModel

      GENDER = ["none","male","female"]

      translates :name, :description
      acts_as_indexed :fields => [:name, :description]

      attr_accessible :site_id, :name, :description, :product_category_id, :picture_id, :gender, :position, :per_page
      validates :name, :presence => true


      belongs_to :site, :class_name => '::Refinery::Sites::Site'
      belongs_to :picture, :class_name => '::Refinery::Image'
      belongs_to :product_category, :class_name => '::Refinery::Sites::ProductCategory'


      def gender_name
        GENDER[self.gender]
      end

      def self.gender_list
        GENDER.each_with_index.map {|gender,index| [gender,index]}
      end

      def search_title
        'products'
      end
    end
  end
end
