class CreateSitesHomePages < ActiveRecord::Migration

  def up
    create_table :refinery_sites_home_pages do |t|
      t.integer :site_id
      t.text :description
      t.integer :logo_id

      t.timestamps
    end

    Refinery::Sites::HomePage.create_translation_table! :description => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/home_pages"})
    end

    drop_table :refinery_sites_home_pages

    Refinery::Sites::HomePage.drop_translation_table!

  end

end
