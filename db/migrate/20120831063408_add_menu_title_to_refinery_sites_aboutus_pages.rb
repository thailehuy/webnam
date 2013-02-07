class AddMenuTitleToRefinerySitesAboutusPages < ActiveRecord::Migration
  def change
    add_column :refinery_sites_aboutus_pages, :menu_title, :string

  end
end
