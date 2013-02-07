class CreateSiteImages < ActiveRecord::Migration
  def change
    create_table :site_images, :id => false do |t|
      t.integer :site_id
      t.integer :gallery_image_id
      t.integer :position
      t.text :caption

      t.timestamps
    end
  end
end
