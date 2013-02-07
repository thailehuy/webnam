class AddImageToRefinerySitesDesign < ActiveRecord::Migration
  def change
    add_column :refinery_sites_designs, :background_image_id, :integer

  end
end
