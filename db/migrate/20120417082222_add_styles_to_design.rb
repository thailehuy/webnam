class AddStylesToDesign < ActiveRecord::Migration
  def change
    add_column :refinery_sites_designs, :h3_style, :string
    add_column :refinery_sites_designs, :table_caption_style, :string
    add_column :refinery_sites_designs, :table_row_style, :string

  end
end
