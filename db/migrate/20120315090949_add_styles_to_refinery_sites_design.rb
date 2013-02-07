class AddStylesToRefinerySitesDesign < ActiveRecord::Migration
  def change
    add_column :refinery_sites_designs, :h1_style, :string

    add_column :refinery_sites_designs, :h2_style, :string

    add_column :refinery_sites_designs, :p_style, :string

    add_column :refinery_sites_designs, :menu_color, :string

    add_column :refinery_sites_designs, :foreground_color, :string

  end
end
