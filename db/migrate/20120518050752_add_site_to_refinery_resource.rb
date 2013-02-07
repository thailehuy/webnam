class AddSiteToRefineryResource < ActiveRecord::Migration
  def change
    add_column :refinery_resources, :site_id, :integer
  end
end
