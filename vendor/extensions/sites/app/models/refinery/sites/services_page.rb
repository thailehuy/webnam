require 'acts_as_indexed'

module Refinery
  module Sites
    class ServicesPage < Refinery::Core::BaseModel

      translates :left_col, :right_col, :menu_title, :seo_title, :seo_keywords, :seo_description
      acts_as_indexed :fields => [:left_col, :right_col]

      def search_title
        'services'
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

    end
  end
end
