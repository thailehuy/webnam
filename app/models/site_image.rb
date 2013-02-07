class SiteImage < ActiveRecord::Base


  belongs_to :gallery_image, :class_name => '::Refinery::Image'
  belongs_to :site, :class_name => '::Refinery::Sites::Site'

  translates :caption

  attr_accessible :gallery_image_id, :position, :locale, :caption
  self.translation_class.send :attr_accessible, :locale


#  before_save do |site_image|
#    site_image.position = (SiteImage .maximum(:position) || -1) + 1
#  end




end
