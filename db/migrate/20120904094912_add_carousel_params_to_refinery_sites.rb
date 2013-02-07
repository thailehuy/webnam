class AddCarouselParamsToRefinerySites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :carousel_pause, :integer, :default => 7000

    add_column :refinery_sites, :carousel_transition, :integer, :default => 1000

  end
end
