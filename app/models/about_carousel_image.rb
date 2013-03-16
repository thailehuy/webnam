class AboutCarouselImage < ActiveRecord::Base
  belongs_to :about_flowing_image, :class_name => '::Refinery::Image', :foreign_key => :flowing_image_id
end
