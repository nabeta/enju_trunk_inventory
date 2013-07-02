class InventoryShelfBarcode < ActiveRecord::Base
  attr_accessible :barcode

  belongs_to :inventory_manage

  def bulk_insert_from_shelves(manage_id, prefix)
  end
end
