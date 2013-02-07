class AddProductsTitleToRefinerySiteTranslations < ActiveRecord::Migration
  def change
    add_column :refinery_site_translations, :products_title, :string

  end
end
