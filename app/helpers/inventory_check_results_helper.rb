module InventoryCheckResultsHelper
  def mark(v)
    if v.present? and v != 0
      return I18n.t('activerecord.attributes.inventory_check_result.result_on_mark')
    else
      return ""
    end
  end
end
