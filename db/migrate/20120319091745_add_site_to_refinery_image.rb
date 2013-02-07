class AddSiteToRefineryImage < ActiveRecord::Migration
  def change
    add_column :refinery_images, :site_id, :integer
  end
end
