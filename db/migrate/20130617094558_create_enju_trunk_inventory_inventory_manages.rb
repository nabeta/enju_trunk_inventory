class CreateEnjuTrunkInventoryInventoryManages < ActiveRecord::Migration
  def change
    create_table :inventory_manages do |t|
      t.string :display_name
      t.string :manifestation_type_ids
      t.string :shelves_group_ids
      t.text :notification_dest
      t.integer :state

      t.timestamps
    end
  end
end
