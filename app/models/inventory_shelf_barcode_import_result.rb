class InventoryShelfBarcodeImportResult < ActiveRecord::Base
  attr_accessible :body, :error_msg, :inventory_shelf_barcode_import_file, :user_id

  default_scope :order => 'inventory_shelf_barcode_import_results.id DESC'

  belongs_to :inventory_shelf_barcode_import_file
end
