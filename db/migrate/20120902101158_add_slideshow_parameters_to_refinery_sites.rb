class AddSlideshowParametersToRefinerySites < ActiveRecord::Migration
  def change
    add_column :refinery_sites, :slide_effect, :string, :default => 'simpleFade'

    add_column :refinery_sites, :slide_delay, :integer, :default => 7000

    add_column :refinery_sites, :slide_transition, :integer, :default => 1500

  end
end
