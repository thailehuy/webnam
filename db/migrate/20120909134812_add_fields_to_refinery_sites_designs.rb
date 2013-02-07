class AddFieldsToRefinerySitesDesigns < ActiveRecord::Migration
  def change
    add_column :refinery_sites_designs, :background_repeat, :integer, :default => 0

  end
end
