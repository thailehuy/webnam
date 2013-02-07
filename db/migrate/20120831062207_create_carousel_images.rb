class CreateCarouselImages < ActiveRecord::Migration
  def change
    create_table :carousel_images do |t|
      t.integer :site_id
      t.integer :flowing_image_id
      t.integer :position
      t.text :caption

      t.timestamps
    end
  end
end
