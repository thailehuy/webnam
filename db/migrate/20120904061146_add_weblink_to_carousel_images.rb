class AddWeblinkToCarouselImages < ActiveRecord::Migration
  def change
    add_column :carousel_images, :weblink, :string

  end
end
