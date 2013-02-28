class AddSeoGalleryTitleToRefinerySites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :seo_gallery_title, :string

  end
end
