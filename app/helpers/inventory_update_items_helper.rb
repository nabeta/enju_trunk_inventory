module InventoryUpdateItemsHelper
  def error_messages
    msg = ""
    if @errors && @errors.present? 
      msg << '<div id="errorExplanation">'
      msg << '<h2>' << I18n.t('page.error_occured') << '</h2>'
      msg << I18n.t('errors.template.body') 
      msg << '<ul>'
      @errors.each do |err| 
        msg << '<li>' << err << '</li>'
      end
      msg << '</ul>'
      msg << '</div>'
    end 
    return msg
  end
end
