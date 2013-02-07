class AddMenuTitleToRefinerySitesServicesPages < ActiveRecord::Migration
  def change
    add_column :refinery_sites_services_pages, :menu_title, :string

  end
end
