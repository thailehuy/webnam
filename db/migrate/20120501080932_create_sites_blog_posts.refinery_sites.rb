# This migration comes from refinery_sites (originally 7)
class CreateSitesBlogPosts < ActiveRecord::Migration

  def up
    create_table :refinery_sites_blog_posts do |t|

      t.integer :site_id

      t.boolean :published

      t.string :title

      t.text :content

      t.integer :position

      t.timestamps
    end

    Refinery::Sites::BlogPost.create_translation_table! :title => :string, :content => :text

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sites"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sites/blog_posts"})
    end

    drop_table :refinery_sites_blog_posts

    Refinery::Sites::BlogPost.drop_translation_table!

  end

end
