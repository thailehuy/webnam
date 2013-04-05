class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.text :note
      t.float :total
      t.boolean :delivered
      t.integer :site_id

      t.timestamps
    end
  end
end
