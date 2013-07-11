class InventoryCheckDataImportResult < ActiveRecord::Base
  attr_accessible :body, :error_msg, :inventory_check_data_import_file_id

  default_scope :order => 'inventory_check_data_import_results.id DESC'

  belongs_to :inventory_check_data_import_file
end
