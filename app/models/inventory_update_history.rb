class InventoryUpdateHistory < ActiveRecord::Base
  attr_accessible :inventory_manage_id, :item_identifier, :before_item, :diffparam

  default_scope order('id')
end
