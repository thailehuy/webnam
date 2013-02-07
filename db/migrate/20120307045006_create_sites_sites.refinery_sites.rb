# This migration comes from refinery_sites (originally 1)
class CreateSitesSites < ActiveRecord::Migration

  def up
    create_table :refinery_sites do |t|
      t.string :name
      t.boolean :published, :default => false
      t.string :slug,       :null => false
      t.string :contact_email,
      t.integer :position

      t.timestamps
    end

    Refinery::Sites::Site.create_translation_table! :name => :string, :slug => :string

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/sites"})
    end

    drop_table :refinery_sites

    Refinery::Sites::Site.drop_translation_table!

  end

end
