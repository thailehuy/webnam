class CreatePrintedCoupons < ActiveRecord::Migration
  def change
    create_table :printed_coupons do |t|
      t.integer :coupon_id
      t.string :email_address

      t.timestamps
    end
  end
end
