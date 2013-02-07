module Refinery
  module Sites
    class Design < Refinery::Core::BaseModel

      BG_REPEAT = ["no-repeat","repeat-x","repeat-y","repeat"]

#      acts_as_indexed :fields => [:scss_model, :background_color, :font_family, :font_color]

#      validates :scss_model, :presence => true

      belongs_to :background_image, :class_name => '::Refinery::Image'

    end
  end
end
