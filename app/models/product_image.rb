class ProductImage < HomeImage
  belongs_to :product_slide_image, :class_name => '::Refinery::Image', :foreign_key => :slide_image_id
end