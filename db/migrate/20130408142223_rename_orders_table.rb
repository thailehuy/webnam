class RenameOrdersTable < ActiveRecord::Migration
  def up
    rename_table :orders, :refinery_sites_orders
  end

  def down
    rename_table :refinery_sites_orders, :orders
  end
end
