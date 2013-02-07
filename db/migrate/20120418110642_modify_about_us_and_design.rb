class ModifyAboutUsAndDesign < ActiveRecord::Migration
  def up

    drop_table :refinery_sites_aboutus_pages

    Refinery::Sites::AboutusPage.drop_translation_table!

    create_table :refinery_sites_aboutus_pages do |t|
      t.integer :site_id

      t.text :left_col
      t.text :right_col

      t.decimal :latitude, :precision => 7, :scale => 4
      t.decimal :longitude, :precision => 7, :scale => 4

      t.timestamps
    end

    Refinery::Sites::AboutusPage.create_translation_table! :left_col => :text, :right_col => :text

    add_column :refinery_sites_designs, :table_border_style, :string

  end

  def down
    drop_table :refinery_sites_aboutus_pages

    Refinery::Sites::AboutusPage.drop_translation_table!

    remove_column :refinery_sites_designs, :table_border_style

  end
end
