class AddMenuTitleToRefinerySitesAboutusPageTranslations < ActiveRecord::Migration
  def change
    add_column :refinery_sites_aboutus_page_translations, :menu_title, :string

  end
end
