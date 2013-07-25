class InventoryCheckDatum < ActiveRecord::Base
  attr_accessible :inventory_manage_id, :read_at, :readcode

  default_scope order('id')
end
