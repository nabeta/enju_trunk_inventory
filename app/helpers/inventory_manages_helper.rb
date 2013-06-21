module InventoryManagesHelper
  def manifestation_type_names(manifestation_type_ids)
    s = ""
    if manifestation_type_ids.present?
      list = ManifestationType.where(:id => manifestation_type_ids).pluck(:display_name)
      if list
        s = list.join(',')
      end
    end
    s
  end

  def shelf_group_names(shelf_group_ids)
    s = ""
    if shelf_group_ids.present?
      list = InventoryShelfGroup.where(:id => shelf_group_ids).pluck(:display_name)
      if list
        s = list.join(',')
      end
    end
    s
  end

  def inventory_manage_state(inventory_manage)
    case inventory_manage.state
    when 0
      I18n.t('activerecord.attributes.inventory_manage.state_name.init')
    else
      I18n.t('activerecord.attributes.inventory_manage.state_name.undefined')
    end
  end

end
