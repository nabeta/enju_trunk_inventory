class InventoryCheckDatum < ActiveRecord::Base
  attr_accessible :inventory_manage_id, :read_at, :readcode, :shelf_name

  validates :readcode, :presence => true
  validates :shelf_name, :presence => true

  default_scope order('id')

  def self.count_items(inventory_manage_id)
    InventoryCheckDatum.where(['inventory_manage_id = ? and shelf_flag = 0', inventory_manage_id]).count('id')
  end
end
