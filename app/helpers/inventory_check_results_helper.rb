module InventoryCheckResultsHelper
  def mark(v, attribute_name = nil)
    mark_label = ""
    if v.present? 
      if v.class == InventoryCheckResult
        value = v.__send__(attribute_name)  
        puts "@@@"
        puts value
        if value.present? && value.to_s != "0"
          if v.try(:skip_flag) == 1
            mark_label = I18n.t('activerecord.attributes.inventory_check_result.result_skip_mark')
          else
            mark_label = I18n.t('activerecord.attributes.inventory_check_result.result_on_mark')
          end
        end
      end
    end
    return mark_label
  end
end
