require 'acts_as_indexed'

module Refinery
  module Sites
    class Coupon < Refinery::Core::BaseModel

      translates :decoration, :title, :description
      acts_as_indexed :fields => [:decoration, :title, :description]

      attr_accessible :site_id, :displayed, :no_coupons_left, :decoration, :title, :description,
                      :expiry, :max_number, :seed_number, :picture_id, :position, :hide_when_finished


      validates :title, :presence => true
      validates :max_number, :presence => true,
                :numericality => {:greater_than => 0, :only_integer => true}
      validates :seed_number, :presence => true,
                :numericality => {:greater_than => 99, :only_integer => true}

      belongs_to :site, :class_name => '::Refinery::Sites::Site'

      has_many :printed_coupons, :dependent => :delete_all

      def search_title
        'coupons'
      end
    end
  end
end
