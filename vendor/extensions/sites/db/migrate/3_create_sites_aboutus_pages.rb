class CreateSitesAboutusPages < ActiveRecord::Migration

  def up
    create_table :refinery_sites_aboutus_pages do |t|
      t.integer :site_id
      t.string :category
      t.date :established
      t.text :features

      t.timestamps
    end

    Refinery::Sites::AboutusPage.create_translation_table! :category => :string, :features => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/aboutus_pages"})
    end

    drop_table :refinery_sites_aboutus_pages

    Refinery::Sites::AboutusPage.drop_translation_table!

  end

end
