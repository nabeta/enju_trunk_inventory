class ShelfBindType
  def self.all
    r = []
    r << OpenStruct.new({:id => "0", :display_name => I18n.t('activerecord.attributes.inventory_manage.bind_name.s0')})
    r
  end
end
