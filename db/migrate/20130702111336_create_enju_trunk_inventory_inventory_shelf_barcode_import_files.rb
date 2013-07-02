class CreateEnjuTrunkInventoryInventoryShelfBarcodeImportFiles < ActiveRecord::Migration
  def change
    create_table :enju_trunk_inventory_inventory_shelf_barcode_import_files do |t|

      t.timestamps
    end
  end
end
