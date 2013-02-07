class AddLogoToRefinerySites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :logo_id, :integer

  end
end
