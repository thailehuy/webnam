class AddTypeToHomeImage < ActiveRecord::Migration
  def change
    add_column :home_images, :type, :string, :default => "HomeImage"

  end
end
