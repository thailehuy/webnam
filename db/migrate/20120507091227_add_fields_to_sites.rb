class AddFieldsToSites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :has_services, :boolean
    add_column :refinery_sites, :has_products, :boolean
    add_column :refinery_sites, :use_categories, :boolean
    add_column :refinery_sites, :use_gender, :boolean
    add_column :refinery_sites, :has_coupons, :boolean
    add_column :refinery_sites, :has_blog, :boolean
    add_column :refinery_sites, :has_events, :boolean
    add_column :refinery_sites, :has_calendars, :boolean
    add_column :refinery_sites, :calendar_mode, :string
    add_column :refinery_sites, :calendar_height, :integer
    add_column :refinery_sites, :facebook_page, :string
    add_column :refinery_sites, :twitter_page, :string
    add_column :refinery_sites, :linkedin_page, :string
    add_column :refinery_sites, :youtube_page, :string
  end
end
