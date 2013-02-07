class HomeImage < ActiveRecord::Base

  belongs_to :slide_image, :class_name => '::Refinery::Image'
  belongs_to :site, :class_name => '::Refinery::Sites::Site'

  translates :caption

  attr_accessible :slide_image_id, :position, :locale, :caption
  self.translation_class.send :attr_accessible, :locale

end
