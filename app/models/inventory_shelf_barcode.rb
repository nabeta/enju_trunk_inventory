class InventoryShelfBarcode < ActiveRecord::Base
  attr_accessible :barcode

  belongs_to :inventory_manage

  def bulk_insert_from_shelves(manage_id, prefix)
    sql = << "EOS" 
insert into inventory_shelf_barcodes (barcode, inventory_manage_id, created_at, updated_at)
  select prefix || name, #{manage_id}, now(), now() from shelves where open_access = 0;
EOS
    connection.execute(sql)
  end
end
