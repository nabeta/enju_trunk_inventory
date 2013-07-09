class InventoryManage < ActiveRecord::Base
  attr_accessible :display_name, :manifestation_type_ids, :notification_dest, :shelf_group_ids, :state, :shelf_groups, :manifestation_types, :bind_type

  validates :display_name, :presence => true

  validate :combined_type_is_valid

  has_many :inventory_shelf_barcodes
  has_many :inventory_check_data

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

  def finished
    self.finished_at = Time.now
    self.state = 9
    self.save!
  end

  def copy_shelves_to_inventory_shelves
=begin
    Shelf.all.each do |shelf|
      sql  = "insert into inventory_shelf_barcodes "
      sql += "(barcode, inventory_manage_id, inventory_shelf_group_id, shelf_id, created_at, updated_at) values "
      sql += "(#{barcode}, #{self.id}, nil, #{shelf.id}, now(), now())"
      ActiveRecord::Base.connection.insert(sql)
    end
=end
  end

  def phase1_check
    notifications = []

    if self.inventory_shelf_barcodes
      n = OpenStruct.new
      n.message = I18n.t("page.no_have_inventory_shelf_barcode")
      notifications << n
    end
    if self.inventory_check_data
      n = OpenStruct.new
      n.message = I18n.t("page.no_have_inventory_check_data")
      notifications << n
    end

    return notifications
  end

  # import from tsv
  def import
    num = {:manifestation_imported => 0, :item_imported => 0, :manifestation_found => 0, :item_found => 0, :failed => 0}
    row_num = 2
    rows = open_import_file
    field = rows.first
    if [field['isbn'], field['original_title']].reject{|field| field.to_s.strip == ""}.empty?
      raise "You should specify isbn or original_tile in the first line"
    end

    rows.each_with_index do |row, index|
      Rails.logger.info("import block start. row_num=#{row_num} index=#{index}")

      next if row['dummy'].to_s.strip.present?
      import_result = ResourceImportResult.create!(:resource_import_file => self, :body => row.fields.join("\t"))

    end

    self.update_attribute(:imported_at, Time.zone.now)
    rows.close
    return num
  end

end
