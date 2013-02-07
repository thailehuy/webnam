class AddSiteToRefineryUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :site_id, :integer

  end
end
