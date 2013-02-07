# This migration comes from refinery_sites (originally 8)
class CreateSitesEvents < ActiveRecord::Migration

  def up
    create_table :refinery_sites_events do |t|

      t.integer :site_id

      t.boolean :published

      t.string :event_title

      t.text :event_summary

      t.date :event_date

      t.timestamps
    end

    Refinery::Sites::Event.create_translation_table! :event_title => :string, :event_summary => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/events"})
    end

    drop_table :refinery_sites_events

    Refinery::Sites::Event.drop_translation_table!

  end

end
