class CreateEnjuTrunkInventoryInventoryShelfGroups < ActiveRecord::Migration
  def change
    create_table :enju_trunk_inventory_inventory_shelf_groups do |t|
      t.string :name
      t.string :display_name

      t.timestamps
    end
  end
end
