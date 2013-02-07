class AddSplashImageToRefineryHomepage < ActiveRecord::Migration
  def change
    add_column :refinery_sites_home_pages, :splash_id, :integer
  end
end
