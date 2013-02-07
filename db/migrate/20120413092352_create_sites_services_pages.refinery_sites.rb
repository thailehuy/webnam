# This migration comes from refinery_sites (originally 5)
class CreateSitesServicesPages < ActiveRecord::Migration

  def up
    create_table :refinery_sites_services_pages do |t|

      t.integer :site_id
      t.text :left_col
      t.text :right_col

      t.timestamps
    end

    Refinery::Sites::ServicesPage.create_translation_table! :left_col => :text, :right_col => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/services_pages"})
    end

    drop_table :refinery_sites_services_pages

    Refinery::Sites::ServicesPage.drop_translation_table!

  end

end
