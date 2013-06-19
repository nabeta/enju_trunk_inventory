class InventoryManage < ActiveRecord::Base
  attr_accessible :display_name, :manifestation_type_ids, :notification_dest, :shelves_group_ids, :state
end
