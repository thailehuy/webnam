require 'acts_as_indexed'

module Refinery
  module Sites
    class ExtraPage < Refinery::Core::BaseModel

      translates :description, :left_col, :right_col, :title
      acts_as_indexed :fields => [:description, :left_col, :right_col]

      belongs_to :site

      attr_accessor :layout
      attr_accessible :description, :left_col, :right_col, :title, :parent_page, :site_id, :layout, :use_carousel, :use_slideshow, :is_submenu, :position, :url, :one_column

      before_save :set_layout

      def search_title
        parent.search_title
      end

      before_save { |m| m.translation.save }
      before_create :ensure_locale

      # Make sures that a translation exists for this page.
      # The translation is set to the default frontend locale.
      def ensure_locale
        unless self.translations.present?
          self.translations.build :locale => ::Refinery::I18n.default_frontend_locale
        end
      end

      private
      def set_layout
        (self.one_column = layout == "one_column") if layout && self.one_column.nil?
        return true
      end
    end
  end
end
