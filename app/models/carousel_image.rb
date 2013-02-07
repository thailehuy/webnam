class CarouselImage < ActiveRecord::Base

  belongs_to :flowing_image, :class_name => '::Refinery::Image'
  belongs_to :site, :class_name => '::Refinery::Sites::Site'

  translates :caption

  attr_accessible :flowing_image_id, :position, :locale, :caption, :weblink
  self.translation_class.send :attr_accessible, :locale

end
