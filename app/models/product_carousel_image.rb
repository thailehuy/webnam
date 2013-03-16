class ProductCarouselImage < CarouselImage
  belongs_to :product_flowing_image, :class_name => '::Refinery::Image', :foreign_key => :flowing_image_id
end
