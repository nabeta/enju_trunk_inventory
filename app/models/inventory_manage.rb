class InventoryManage < ActiveRecord::Base
  attr_accessible :display_name, :manifestation_type_ids, :notification_dest, :shelf_group_ids, :state, :shelf_groups, :manifestation_types

  validates :display_name, :presence => true

  validate :combined_type_is_valid

  def combined_type_is_valid
    if self.manifestation_type_ids.present? || self.shelf_group_ids.present?
      return true 
    end
    false
  end

  def manifestation_types
    self.manifestation_type_ids.split(',') rescue []
  end

  def manifestation_types=(manifestation_types)
    self.manifestation_type_ids = manifestation_types.join(',')
  end

  def shelf_groups
    self.shelf_group_ids.split(',') rescue []
  end

  def shelf_groups=(shelf_groups)
    self.shelf_group_ids = shelf_groups.join(',')
  end

end
