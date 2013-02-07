class AddDisplayOptionsToRefinerySites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :language_display, :integer, :default => 1

    add_column :refinery_sites, :carousel_display, :integer, :default => 0

  end
end
