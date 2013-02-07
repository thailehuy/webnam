# This migration comes from refinery_sites (originally 10)
class CreateSitesProducts < ActiveRecord::Migration

  def up
    create_table :refinery_sites_products do |t|

      t.string :name

      t.text :description

      t.integer :picture_id

      t.integer :product_category_id

      t.integer :gender

      t.integer :site_id

      t.integer :position

      t.timestamps
    end

    Refinery::Sites::Product.create_translation_table! :name => :string, :description => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/products"})
    end

    drop_table :refinery_sites_products

    Refinery::Sites::Product.drop_translation_table!

  end

end
