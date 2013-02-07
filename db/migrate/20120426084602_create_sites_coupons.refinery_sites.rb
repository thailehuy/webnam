# This migration comes from refinery_sites (originally 6)
class CreateSitesCoupons < ActiveRecord::Migration

  def up
    create_table :refinery_sites_coupons do |t|

      t.integer :site_id

      t.boolean :displayed

      t.boolean :no_coupons_left, :default => false

      t.text :decoration

      t.text :title

      t.text :description

      t.date :expiry

      t.integer :max_number

      t.integer :seed_number

      t.integer :position

      t.timestamps
    end

    Refinery::Sites::Coupon.create_translation_table! :decoration => :text, :title => :text, :description => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/coupons"})
    end

    drop_table :refinery_sites_coupons

    Refinery::Sites::Coupon.drop_translation_table!

  end

end
