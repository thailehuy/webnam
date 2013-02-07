class CreateHomeImages < ActiveRecord::Migration
  def change
    create_table :home_images do |t|
      t.integer :site_id
      t.integer :slide_image_id
      t.integer :position
      t.text :caption

      t.timestamps
    end
  end
end
