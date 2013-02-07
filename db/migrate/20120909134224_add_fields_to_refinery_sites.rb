class AddFieldsToRefinerySites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :slide_display, :integer, :default => 1

    add_column :refinery_sites, :has_gallery, :boolean, :default => 0

  end
end
