class InventoryShelfGroup < ActiveRecord::Base
  attr_accessible :display_name, :name

  validates :name,  :presence => true, :uniqueness=>true, :format => { :with => /\A[a-zA-Z0-9]+\z/,
          :message => I18n.t('errors.messages.en_expected')}
  validates :display_name, :presence => true

  has_many :inventory_shelf_barcodes
end
