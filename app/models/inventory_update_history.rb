class InventoryUpdateHistory < ActiveRecord::Base
  attr_accessible :inventory_manage_id, :item_identifier, :before_item, :diffparam

  default_scope order('id')

  def pretty_before_item
    hash = JSON.parse(self.before_item)
    hash['item']
  end

  def pretty_diffparam
    item = self.diffparam
  end
end
