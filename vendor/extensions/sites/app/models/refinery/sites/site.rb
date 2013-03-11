require 'acts_as_indexed'

module Refinery
  module Sites
    class Site < Refinery::Core::BaseModel
      self.table_name = 'refinery_sites'

      #:name, :slug,
      translates :products_title, :seo_product_title, :seo_product_keywords, :seo_product_description, :seo_gallery_title


      acts_as_indexed :fields => [:name, :slug]

      validates :name, :presence => true, :uniqueness => {:case_sensitive => false},
                :exclusion => { :in => 'New site',
                                :message => t('site_name_not_unique', :scope => 'activerecord.errors.models.refinery/sites/site') }
      validates :contact_email, :presence => true
      validates :products_per_page, :presence => true, :inclusion => 5..50

      extend FriendlyId
      friendly_id :name, :use => [:reserved, :slugged],  #, :globalize
								  :reserved_words => %w(index new session login logout users refinery admin images wymiframe)

      attr_accessible :name, :published, :languages, :carousel_pages,
                      :position, :slug, :contact_email, :logo_id, :videos, :has_services, :products_per_page,
                      :has_products,:use_categories,:use_gender,:has_gallery, :has_coupons,:has_blog,
                      :has_events,:has_calendars,:calendar_mode,:calendar_height,
                      :facebook_page,:twitter_page,:linkedin_page,:youtube_page, :zingme_page, :govn_page,
                      :flags_position, :flags_border, :virtual_tour_id, :music_id, :webnam_logo_id, :products_title,
                      :slide_effect, :slide_delay, :slide_transition, :carousel_pause, :carousel_transition,
                      :seo_product_title, :seo_product_keywords, :seo_product_description, :analytics_code, :seo_gallery_title, :activated, :favicon_id


      # Don't change the below list as it is used in a bit mask for displaying the carousel
      SITE_PAGES = ["home","aboutus","services","products","coupons","mediagallery","blog","events"]

      belongs_to :logo, :class_name => '::Refinery::Image'
      belongs_to :favicon, :class_name => "::Refinery::Image"
      belongs_to :webnam_logo, :class_name => '::Refinery::Image'
      belongs_to :virtual_tour, :class_name => '::Refinery::Image'
      belongs_to :music, :class_name => '::Refinery::Resource'

      has_one :design, :dependent => :destroy
			accepts_nested_attributes_for :design, :allow_destroy => true
			attr_accessible :design_attributes

			has_one :home_page, :dependent => :destroy
	    accepts_nested_attributes_for :home_page, :allow_destroy => true
      attr_accessible :home_page_attributes

      has_one :aboutus_page, :dependent => :destroy
      accepts_nested_attributes_for :aboutus_page, :allow_destroy => true
	    attr_accessible :aboutus_page_attributes

      has_one :services_page, :dependent => :destroy
      accepts_nested_attributes_for :services_page, :allow_destroy => true
      attr_accessible :services_page_attributes

      has_many :coupons, :dependent => :destroy
      has_many :blog_posts, :dependent => :destroy
      has_many :events, :dependent => :destroy
      has_many :products, :dependent => :destroy
      has_many :product_categories, :dependent => :destroy

      has_many :google_calendars, :dependent => :destroy

      LANGUAGE_NAMES = %w[English Vietnamese French]
      LANGUAGE_CODES = %w[en vn fr]

      def languages=(languages)
        self.language_display = (languages & LANGUAGE_NAMES).map {
            |field| 2**LANGUAGE_NAMES.index(field) }.sum
      end

      def languages
        LANGUAGE_NAMES.reject { |field| ((language_display || 0) & 2**LANGUAGE_NAMES.index(field)).zero? }
      end

      def languages_key
        LANGUAGE_CODES.reject { |field| ((language_display || 0) & 2**LANGUAGE_CODES.index(field)).zero? }
      end

      has_many :site_images, :dependent => :destroy, :order => 'position ASC'
      has_many :gallery_images, :class_name => '::Refinery::Image', :through => :site_images, :order => 'position ASC'
      accepts_nested_attributes_for :gallery_images, :allow_destroy => false
      attr_accessible :gallery_images_attributes

      # need to do it this way because of the way accepts_nested_attributes_for
      # deletes an already defined images_attributes
      def gallery_images_attributes=(data)
        ids_to_keep = data.map{|i, d| d['site_image_id']}.compact

        site_images_to_delete = if ids_to_keep.empty?
                                  self.site_images
                                else
                                  self.site_images.where(
                                      SiteImage.arel_table[:id].not_in(ids_to_keep)
                                  )
                                end

        site_images_to_delete.destroy_all

        data.each do |i, image_data|
          site_image_id, image_id, caption =
              image_data.values_at('site_image_id', 'id', 'caption')

          next if image_id.blank?

          site_image = if site_image_id.present?
                         self.site_images.find(site_image_id)
                       else
                         self.site_images.build(:gallery_image_id => image_id)
                       end

          site_image.position = i
          site_image.caption = caption
          site_image.save
        end
      end


      def caption_for_gallery_image_index(index)
        self.site_images[index].try(:caption).presence || ""
      end

      def site_image_id_for_image_index(index)
        self.site_images[index].try(:id)
      end


      # Carousel d'images

      def carousel_pages=(carousel_pages)
        self.carousel_display = (carousel_pages & SITE_PAGES).map {
            |field| 2**SITE_PAGES.index(field) }.sum
      end

      def carousel_pages
        SITE_PAGES.reject { |field| ((carousel_display || 0) & 2**SITE_PAGES.index(field)).zero? }
      end


      has_many :carousel_images, :dependent => :destroy, :order => 'position ASC'
      has_many :flowing_images, :class_name => '::Refinery::Image', :through => :carousel_images, :order => 'position ASC'
      accepts_nested_attributes_for :flowing_images, :allow_destroy => false
      attr_accessible :flowing_images_attributes

       # need to do it this way because of the way accepts_nested_attributes_for
      # deletes an already defined images_attributes
      def flowing_images_attributes=(data)
        ids_to_keep = data.map{|i, d| d['carousel_image_id']}.compact

        carousel_images_to_delete = if ids_to_keep.empty?
                                  self.carousel_images
                                else
                                  self.carousel_images.where(
                                      CarouselImage.arel_table[:id].not_in(ids_to_keep)
                                  )
                                end

        carousel_images_to_delete.destroy_all

        data.each do |i, image_data|
          carousel_image_id, image_id, caption, weblink =
              image_data.values_at('carousel_image_id', 'id', 'caption', 'weblink')

          next if image_id.blank?

          carousel_image = if carousel_image_id.present?
                         self.carousel_images.find(carousel_image_id)
                       else
                         self.carousel_images.build(:flowing_image_id => image_id)
                       end

          carousel_image.position = i
          carousel_image.caption = caption
          carousel_image.weblink = weblink
          carousel_image.save
        end
      end

      def caption_for_flowing_image_index(index)
        self.carousel_images[index].try(:caption).presence || ""
      end

      def carousel_image_id_for_image_index(index)
        self.carousel_images[index].try(:id)
      end

      def weblink_for_flowing_image_index(index)
        self.carousel_images[index].try(:weblink).presence || ""
      end

      # Slide show d'images

      has_many :home_images, :dependent => :destroy, :order => 'position ASC'
      has_many :slide_images, :class_name => '::Refinery::Image', :through => :home_images, :order => 'position ASC'
      accepts_nested_attributes_for :slide_images, :allow_destroy => false
      attr_accessible :slide_images_attributes

      # need to do it this way because of the way accepts_nested_attributes_for
      # deletes an already defined images_attributes
      def slide_images_attributes=(data)
        ids_to_keep = data.map{|i, d| d['home_image_id']}.compact

        home_images_to_delete = if ids_to_keep.empty?
                                      self.home_images
                                    else
                                      self.home_images.where(
                                          HomeImage.arel_table[:id].not_in(ids_to_keep)
                                      )
                                    end

        home_images_to_delete.destroy_all

        data.each do |i, image_data|
          home_image_id, image_id, caption =
              image_data.values_at('home_image_id', 'id', 'caption')

          next if image_id.blank?

          home_image = if home_image_id.present?
                             self.home_images.find(home_image_id)
                           else
                             self.home_images.build(:slide_image_id => image_id)
                           end

          home_image.position = i
          home_image.caption = caption
          home_image.save
        end
      end


      def caption_for_slide_image_index(index)
        self.home_images[index].try(:caption).presence || ""
      end

      def home_image_id_for_image_index(index)
        self.home_images[index].try(:id)
      end















      after_destroy :destroy_resources

      def destroy_resources
        ::Refinery::Image.destroy_all(:site_id => self.id)
        ::Refinery::Resource.destroy_all(:site_id => self.id)
        ::Refinery::User.destroy_all(:site_id => self.id)
      end

      def search_title
        'mediagallery'
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
