class AddFaviconIdToRefinerySites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :favicon_id, :integer

  end
end
