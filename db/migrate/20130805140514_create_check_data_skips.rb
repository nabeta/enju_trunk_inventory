class CreateCheckDataSkips < ActiveRecord::Migration
  def change
    create_table :inventory_check_data_skips do |t|
      t.integer :inventory_manage_id
      t.string :item_identifier
      t.integer :inventory_check_result_id
      t.integer :inventory_check_datum_id
      t.text :note
      t.integer :created_by

      t.timestamps
    end
    add_index :inventory_check_data_skips, [:inventory_manage_id, :item_identifier], :unique => true, :name => 'inventory_check_data_skips_index1'
    add_index :inventory_check_data_skips, [:inventory_manage_id, :inventory_check_result_id], :name => 'inventory_check_data_skips_index2'
    add_index :inventory_check_data_skips, [:inventory_manage_id, :inventory_check_datum_id], :name => 'inventory_check_data_skips_index3'
  end
end
