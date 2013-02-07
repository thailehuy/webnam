module Refinery
  module Sites
    module Admin
      class CouponsController < ::Refinery::AdminController

        crudify :'refinery/sites/coupon', :xhr_paging => true

        def find_all_coupons(conditions='')

          if @editing_site
            @coupons = Coupon.where(conditions).where({:site_id => session[:current_site]}).order("position")
          else
            @coupons = Coupon.where(conditions).order("position")
          end
        end

        def new
          @coupon = Coupon.new
          @coupon.site_id = session[:current_site]
          @coupon.seed_number = 100
          @coupon.max_number = 50
        end

      end
    end
  end
end
