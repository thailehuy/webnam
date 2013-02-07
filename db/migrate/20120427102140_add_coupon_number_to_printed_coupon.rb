class AddCouponNumberToPrintedCoupon < ActiveRecord::Migration
  def change
    add_column :printed_coupons, :coupon_number, :integer

  end
end
