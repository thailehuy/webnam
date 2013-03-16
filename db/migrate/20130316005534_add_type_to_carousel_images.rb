class AddTypeToCarouselImages < ActiveRecord::Migration
  def change
    add_column :carousel_images, :type, :string, :default => "CarouselImage"
  end
end
