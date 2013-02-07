# This migration comes from refinery_sites (originally 9)
class CreateSitesProductCategories < ActiveRecord::Migration

  def up
    create_table :refinery_sites_product_categories do |t|

      t.integer :site_id

      t.string :name

      t.integer :position

      t.timestamps
    end

    Refinery::Sites::ProductCategory.create_translation_table! :name => :string

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/product_categories"})
    end

    drop_table :refinery_sites_product_categories

    Refinery::Sites::ProductCategory.drop_translation_table!

  end

end
