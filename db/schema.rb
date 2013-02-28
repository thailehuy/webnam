# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130228012510) do

  create_table "carousel_image_translations", :force => true do |t|
    t.integer  "carousel_image_id"
    t.string   "locale"
    t.text     "caption"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "carousel_image_translations", ["carousel_image_id"], :name => "index_b045b934a95783697096c8dcacc7411e772c07c9"
  add_index "carousel_image_translations", ["locale"], :name => "index_carousel_image_translations_on_locale"

  create_table "carousel_images", :force => true do |t|
    t.integer  "site_id"
    t.integer  "flowing_image_id"
    t.integer  "position"
    t.text     "caption"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "weblink"
  end

  create_table "home_image_translations", :force => true do |t|
    t.integer  "home_image_id"
    t.string   "locale"
    t.text     "caption"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "home_image_translations", ["home_image_id"], :name => "index_home_image_translations_on_home_image_id"
  add_index "home_image_translations", ["locale"], :name => "index_home_image_translations_on_locale"

  create_table "home_images", :force => true do |t|
    t.integer  "site_id"
    t.integer  "slide_image_id"
    t.integer  "position"
    t.text     "caption"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "printed_coupons", :force => true do |t|
    t.integer  "coupon_id"
    t.string   "email_address"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "coupon_number"
  end

  create_table "refinery_image_page_translations", :force => true do |t|
    t.integer  "refinery_image_page_id"
    t.string   "locale"
    t.text     "caption"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "refinery_image_page_translations", ["locale"], :name => "index_refinery_image_page_translations_on_locale"
  add_index "refinery_image_page_translations", ["refinery_image_page_id"], :name => "index_186c9a170a0ab319c675aa80880ce155d8f47244"

  create_table "refinery_image_pages", :force => true do |t|
    t.integer "image_id"
    t.integer "page_id"
    t.integer "position"
    t.text    "caption"
    t.string  "page_type", :default => "page"
  end

  add_index "refinery_image_pages", ["image_id"], :name => "index_refinery_image_pages_on_image_id"
  add_index "refinery_image_pages", ["page_id"], :name => "index_refinery_image_pages_on_page_id"

  create_table "refinery_images", :force => true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.string   "image_ext"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "site_id"
  end

  create_table "refinery_page_part_translations", :force => true do |t|
    t.integer  "refinery_page_part_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "refinery_page_part_translations", ["locale"], :name => "index_refinery_page_part_translations_on_locale"
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], :name => "index_f9716c4215584edbca2557e32706a5ae084a15ef"

  create_table "refinery_page_parts", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_parts", ["id"], :name => "index_refinery_page_parts_on_id"
  add_index "refinery_page_parts", ["refinery_page_id"], :name => "index_refinery_page_parts_on_refinery_page_id"

  create_table "refinery_page_translations", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_translations", ["locale"], :name => "index_refinery_page_translations_on_locale"
  add_index "refinery_page_translations", ["refinery_page_id"], :name => "index_d079468f88bff1c6ea81573a0d019ba8bf5c2902"

  create_table "refinery_pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.boolean  "draft",               :default => false
    t.boolean  "skip_to_first_child", :default => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "refinery_pages", ["depth"], :name => "index_refinery_pages_on_depth"
  add_index "refinery_pages", ["id"], :name => "index_refinery_pages_on_id"
  add_index "refinery_pages", ["lft"], :name => "index_refinery_pages_on_lft"
  add_index "refinery_pages", ["parent_id"], :name => "index_refinery_pages_on_parent_id"
  add_index "refinery_pages", ["rgt"], :name => "index_refinery_pages_on_rgt"

  create_table "refinery_resources", :force => true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "site_id"
  end

  create_table "refinery_roles", :force => true do |t|
    t.string "title"
  end

  create_table "refinery_roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], :name => "index_refinery_roles_users_on_role_id_and_user_id"
  add_index "refinery_roles_users", ["user_id", "role_id"], :name => "index_refinery_roles_users_on_user_id_and_role_id"

  create_table "refinery_site_translations", :force => true do |t|
    t.integer  "refinery_site_id"
    t.string   "locale"
    t.string   "name"
    t.string   "slug"
    t.string   "products_title"
    t.string   "seo_product_title"
    t.string   "seo_product_keywords"
    t.string   "seo_product_description"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "seo_gallery_title"
  end

  add_index "refinery_site_translations", ["locale"], :name => "index_refinery_site_translations_on_locale"
  add_index "refinery_site_translations", ["refinery_site_id"], :name => "index_98933849ba63f59dff8f9983301fcdbe3f83d8cf"

  create_table "refinery_sites", :force => true do |t|
    t.string   "name"
    t.boolean  "published",                         :default => false
    t.string   "slug",                                                        :null => false
    t.string   "contact_email"
    t.integer  "position"
    t.integer  "logo_id"
    t.integer  "webnam_logo_id"
    t.integer  "virtual_tour_id"
    t.integer  "music_id"
    t.integer  "language_display",                  :default => 1
    t.integer  "carousel_display",                  :default => 0
    t.text     "videos"
    t.boolean  "has_services"
    t.boolean  "has_products"
    t.string   "products_title"
    t.boolean  "use_categories"
    t.boolean  "use_gender"
    t.boolean  "has_coupons"
    t.boolean  "has_blog"
    t.boolean  "has_events"
    t.boolean  "has_calendars"
    t.string   "calendar_mode"
    t.integer  "calendar_height"
    t.string   "facebook_page"
    t.string   "twitter_page"
    t.string   "linkedin_page"
    t.string   "youtube_page"
    t.string   "zingme_page"
    t.string   "govn_page"
    t.string   "flags_position",      :limit => 10
    t.string   "flags_border",        :limit => 45
    t.string   "analytics_code",      :limit => 16
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.string   "slide_effect",                      :default => "simpleFade"
    t.integer  "slide_delay",                       :default => 7000
    t.integer  "slide_transition",                  :default => 1500
    t.integer  "carousel_pause",                    :default => 7000
    t.integer  "carousel_transition",               :default => 1000
    t.integer  "slide_display",                     :default => 1
    t.boolean  "has_gallery",                       :default => false
    t.integer  "products_per_page",                 :default => 10
    t.integer  "favicon_id"
    t.string   "seo_gallery_title"
  end

  create_table "refinery_sites_aboutus_page_translations", :force => true do |t|
    t.integer  "refinery_sites_aboutus_page_id"
    t.string   "locale"
    t.string   "menu_title"
    t.text     "left_col"
    t.text     "right_col"
    t.string   "seo_title"
    t.string   "seo_keywords"
    t.string   "seo_description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "refinery_sites_aboutus_page_translations", ["locale"], :name => "index_refinery_sites_aboutus_page_translations_on_locale"
  add_index "refinery_sites_aboutus_page_translations", ["refinery_sites_aboutus_page_id"], :name => "index_7fa3dc35e181ad80c2e6df69709613c736442ed8"

  create_table "refinery_sites_aboutus_pages", :force => true do |t|
    t.integer  "site_id"
    t.string   "menu_title"
    t.text     "left_col"
    t.text     "right_col"
    t.decimal  "latitude",   :precision => 7, :scale => 4
    t.decimal  "longitude",  :precision => 7, :scale => 4
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "refinery_sites_blog_post_translations", :force => true do |t|
    t.integer  "refinery_sites_blog_post_id"
    t.string   "locale"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "refinery_sites_blog_post_translations", ["locale"], :name => "index_refinery_sites_blog_post_translations_on_locale"
  add_index "refinery_sites_blog_post_translations", ["refinery_sites_blog_post_id"], :name => "index_f7bf7562efb36259126d02ba8bc041c6ca0690af"

  create_table "refinery_sites_blog_posts", :force => true do |t|
    t.integer  "site_id"
    t.boolean  "published"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_sites_coupon_translations", :force => true do |t|
    t.integer  "refinery_sites_coupon_id"
    t.string   "locale"
    t.text     "decoration"
    t.text     "title"
    t.text     "description"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "refinery_sites_coupon_translations", ["locale"], :name => "index_refinery_sites_coupon_translations_on_locale"
  add_index "refinery_sites_coupon_translations", ["refinery_sites_coupon_id"], :name => "index_986967cd584e43194bf465691f46426e40810397"

  create_table "refinery_sites_coupons", :force => true do |t|
    t.integer  "site_id"
    t.boolean  "displayed"
    t.boolean  "no_coupons_left",    :default => false
    t.text     "decoration"
    t.text     "title"
    t.text     "description"
    t.date     "expiry"
    t.integer  "max_number"
    t.integer  "seed_number"
    t.integer  "position"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "hide_when_finished", :default => true
  end

  create_table "refinery_sites_designs", :force => true do |t|
    t.integer  "site_id"
    t.string   "scss_model"
    t.string   "background_color"
    t.string   "font_family"
    t.string   "font_color"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "background_image_id"
    t.string   "h1_style"
    t.string   "h2_style"
    t.string   "p_style"
    t.string   "menu_style"
    t.string   "menu_color"
    t.string   "foreground_color"
    t.string   "h3_style"
    t.string   "table_caption_style"
    t.string   "table_row_style"
    t.string   "table_border_style"
    t.integer  "background_repeat",   :default => 0
  end

  create_table "refinery_sites_event_translations", :force => true do |t|
    t.integer  "refinery_sites_event_id"
    t.string   "locale"
    t.string   "event_title"
    t.text     "event_summary"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "refinery_sites_event_translations", ["locale"], :name => "index_refinery_sites_event_translations_on_locale"
  add_index "refinery_sites_event_translations", ["refinery_sites_event_id"], :name => "index_d769a8b656fdd28214248e9945cd057ec9800ca7"

  create_table "refinery_sites_events", :force => true do |t|
    t.integer  "site_id"
    t.boolean  "published"
    t.string   "event_title"
    t.text     "event_summary"
    t.date     "event_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "refinery_sites_google_calendars", :force => true do |t|
    t.integer  "site_id"
    t.string   "account"
    t.string   "bg_color"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_sites_home_page_translations", :force => true do |t|
    t.integer  "refinery_sites_home_page_id"
    t.string   "locale"
    t.text     "description"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "seo_title"
    t.string   "seo_keywords"
    t.string   "seo_description"
  end

  add_index "refinery_sites_home_page_translations", ["locale"], :name => "index_refinery_sites_home_page_translations_on_locale"
  add_index "refinery_sites_home_page_translations", ["refinery_sites_home_page_id"], :name => "index_cc1abd768648776fa35b3b9bbf3bf1e415dfc457"

  create_table "refinery_sites_home_pages", :force => true do |t|
    t.integer  "site_id"
    t.text     "description"
    t.integer  "logo_id"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "splash_id"
  end

  create_table "refinery_sites_product_categories", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_sites_product_category_translations", :force => true do |t|
    t.integer  "refinery_sites_product_category_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "refinery_sites_product_category_translations", ["locale"], :name => "index_refinery_sites_product_category_translations_on_locale"
  add_index "refinery_sites_product_category_translations", ["refinery_sites_product_category_id"], :name => "index_2352d26ccc74d00cb05ee37fd71c621e998474bf"

  create_table "refinery_sites_product_translations", :force => true do |t|
    t.integer  "refinery_sites_product_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "refinery_sites_product_translations", ["locale"], :name => "index_refinery_sites_product_translations_on_locale"
  add_index "refinery_sites_product_translations", ["refinery_sites_product_id"], :name => "index_aeef4b0356378fc0ab7f0393f418ccb3f0e432cb"

  create_table "refinery_sites_products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "picture_id"
    t.integer  "product_category_id"
    t.integer  "gender"
    t.integer  "site_id"
    t.integer  "position"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "refinery_sites_services_page_translations", :force => true do |t|
    t.integer  "refinery_sites_services_page_id"
    t.string   "locale"
    t.string   "menu_title"
    t.text     "left_col"
    t.text     "right_col"
    t.string   "seo_title"
    t.string   "seo_keywords"
    t.string   "seo_description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "refinery_sites_services_page_translations", ["locale"], :name => "index_refinery_sites_services_page_translations_on_locale"
  add_index "refinery_sites_services_page_translations", ["refinery_sites_services_page_id"], :name => "index_08d58822e6961e94e91148298a1199548e87acc9"

  create_table "refinery_sites_services_pages", :force => true do |t|
    t.integer  "site_id"
    t.string   "menu_title"
    t.text     "left_col"
    t.text     "right_col"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], :name => "index_refinery_user_plugins_on_name"
  add_index "refinery_user_plugins", ["user_id", "name"], :name => "index_refinery_user_plugins_on_user_id_and_name", :unique => true

  create_table "refinery_users", :force => true do |t|
    t.string   "username",               :null => false
    t.string   "email",                  :null => false
    t.string   "encrypted_password",     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "site_id"
    t.string   "slug"
  end

  add_index "refinery_users", ["id"], :name => "index_refinery_users_on_id"
  add_index "refinery_users", ["slug"], :name => "index_refinery_users_on_slug"

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "seo_meta", ["id"], :name => "index_seo_meta_on_id"
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], :name => "index_seo_meta_on_seo_meta_id_and_seo_meta_type"

  create_table "site_image_translations", :force => true do |t|
    t.integer  "site_image_id"
    t.string   "locale"
    t.text     "caption"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "site_image_translations", ["locale"], :name => "index_site_image_translations_on_locale"
  add_index "site_image_translations", ["site_image_id"], :name => "index_site_image_translations_on_site_image_id"

  create_table "site_images", :force => true do |t|
    t.integer  "site_id"
    t.integer  "gallery_image_id"
    t.integer  "position"
    t.text     "caption"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
