class AddProductsTitleToRefinerySites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :products_title, :string

  end
end
