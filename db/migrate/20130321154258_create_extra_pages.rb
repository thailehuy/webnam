class CreateExtraPages < ActiveRecord::Migration
  def up
    create_table :refinery_sites_extra_pages do |t|
      t.integer :site_id
      t.text :description
      t.text :left_col
      t.text :right_col
      t.boolean :one_column
      t.integer :position
      t.string :parent_page
      t.boolean :use_carousel
      t.boolean :use_slideshow
      t.boolean :is_submenu
      t.string :title
      t.string :url

      t.timestamps
    end

    Refinery::Sites::ExtraPage.create_translation_table! :description => :text, :left_col => :text, :right_col => :text, :title => :string

  end

  def down
    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/extra_pages"})
    end

    drop_table :refinery_sites_extra_pages

    Refinery::Sites::ExtraPage.drop_translation_table!

  end
end
