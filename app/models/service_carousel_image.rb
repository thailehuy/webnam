class ServiceCarouselImage < ActiveRecord::Base
  belongs_to :service_flowing_image, :class_name => '::Refinery::Image', :foreign_key => :flowing_image_id
end
