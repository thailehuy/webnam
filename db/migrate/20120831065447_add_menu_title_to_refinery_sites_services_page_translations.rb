class AddMenuTitleToRefinerySitesServicesPageTranslations < ActiveRecord::Migration
  def change
    add_column :refinery_sites_services_page_translations, :menu_title, :string

  end
end
