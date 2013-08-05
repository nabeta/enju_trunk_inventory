class InventoryCheckDataSkip < ActiveRecord::Base
  attr_accessible :inventory_manage_id, :item_identifier, :inventory_check_result_id, :inventory_check_datum_id, :note, :created_by

  validates :inventory_manage_id, :presence => true
  validates :item_identifier, :presence => true
end
