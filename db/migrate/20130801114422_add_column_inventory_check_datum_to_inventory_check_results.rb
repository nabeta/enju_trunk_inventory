class AddColumnInventoryCheckDatumToInventoryCheckResults < ActiveRecord::Migration
  def change
    add_column :inventory_check_results, :inventory_check_datum_id, :integer
  end
end
