class AddActivatedToRefinerySites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :activated, :boolean

  end
end
