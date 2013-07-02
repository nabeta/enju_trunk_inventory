class CreateEnjuTrunkInventoryInventoryCheckResults < ActiveRecord::Migration
  def change
    create_table :inventory_check_results do |t|
      t.integer :inventory_manage_id
      t.integer :status_1
      t.integer :status_2
      t.integer :status_3
      t.integer :status_4
      t.integer :status_5
      t.integer :status_6
      t.integer :status_7
      t.integer :status_8
      t.integer :status_9

      t.timestamps
    end
  end
end
