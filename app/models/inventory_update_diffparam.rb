require 'active_attr'
class InventoryUpdateDiffparam
  include ActiveAttr::Model

  attribute :skip_flag
  attribute :shelf
  attribute :circulation_status_id

  validates :skip_flag, :inclusion => {:in => [true, false]}
  validates :name, :presence => true
end
