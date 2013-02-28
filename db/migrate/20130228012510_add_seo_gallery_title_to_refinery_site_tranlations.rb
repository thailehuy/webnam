class AddSeoGalleryTitleToRefinerySiteTranlations < ActiveRecord::Migration
  def change
    add_column :refinery_site_translations, :seo_gallery_title, :string

  end
end
