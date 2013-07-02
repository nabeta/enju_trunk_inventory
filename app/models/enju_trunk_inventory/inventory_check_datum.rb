module EnjuTrunkInventory
  class InventoryCheckDatum < ActiveRecord::Base
    attr_accessible :inventory_manage_id, :read_at, :readcode
  end
end
