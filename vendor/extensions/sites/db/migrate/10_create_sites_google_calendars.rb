class CreateSitesGoogleCalendars < ActiveRecord::Migration

  def up
    create_table :refinery_sites_google_calendars do |t|

      t.integer :site_id

      t.string :account

      t.string :bg_color

      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/google_calendars"})
    end

    drop_table :refinery_sites_google_calendars

  end

end
