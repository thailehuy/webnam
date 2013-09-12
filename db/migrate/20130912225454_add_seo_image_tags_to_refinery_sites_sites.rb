class AddSeoImageTagsToRefinerySitesSites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :seo_image_tags, :string
  end
end
