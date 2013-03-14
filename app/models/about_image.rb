class AboutImage < HomeImage
  belongs_to :about_slide_image, :class_name => '::Refinery::Image', :foreign_key => :slide_image_id
end