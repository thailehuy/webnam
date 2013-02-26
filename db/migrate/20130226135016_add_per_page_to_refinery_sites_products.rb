class AddPerPageToRefinerySitesProducts < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :products_per_page, :integer, :default => 10

  end
end
