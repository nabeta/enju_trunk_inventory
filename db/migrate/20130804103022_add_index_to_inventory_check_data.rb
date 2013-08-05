class AddIndexToInventoryCheckData < ActiveRecord::Migration
  def change
    add_index :inventory_check_data, [:inventory_manage_id, :readcode, :shelf_name], :name => "inventory_check_data_index_1"
  end
end
