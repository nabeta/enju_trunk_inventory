# coding: utf-8 
class EnjuTrunkInventoryCheckError < StandardError ; end

class InventoryManage < ActiveRecord::Base
  attr_accessible :display_name, :manifestation_type_ids, :notification_dest, :shelf_group_ids, :state, :shelf_groups, :manifestation_types, :bind_type

  validates :display_name, :presence => true

  validate :combined_type_is_valid

  has_many :inventory_shelf_barcodes
  has_many :inventory_check_data
  has_many :inventory_check_results

  def combined_type_is_valid
    if self.manifestation_type_ids.present? || self.shelf_group_ids.present?
      return true 
    end
    errors[:base] << I18n.t("activerecord.attributes.inventory_manage.has_error_combined_type_is_valid")
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

  def check
    logger.info("start check")
    check_start 

    check_list = {}

    InventoryCheckResult.delete_all(["inventory_manage_id = ?", self.id])
   
    shelf_groups_ids = self.shelf_group_ids.split
    shelf_barcode_shelf_ids = InventoryShelfBarcode.where(:inventory_manage_id => self.id, :inventory_shelf_group_id => shelf_groups_ids).pluck(:shelf_id)

    if shelf_barcode_shelf_ids.empty?
      raise EnjuTrunkInventoryCheckError("ShelfBarcode is empry.")
    end
    
    # check1(所在不明)
    # システム内に存在するのに、点検データには存在しない。
    check_list[:status_1] = check1(self.id, shelf_barcode_shelf_ids)
    
    # check2(配架間違い)
    check21_list = check21(self.id, self.manifestation_type_ids) 
    check22_list = check22(self.id) 
    check_list[:status_2] = check21_list + check22_list
   
    # check3(乱れ)
    check_list[:status_3] = check3(self.id)
    
    check_data = InventoryCheckDatum.where(:inventory_manage_id => self.id, :shelf_flag => 0).pluck(:readcode)

    # check4(貸出中)
    # システムでは貸出中であり、点検データには存在しない場合。
    check_list[:status_4] = check4(self.id, shelf_barcode_shelf_ids, check_data)

    # check5(未返却)
    check_list[:status_5] = check5(self.id, shelf_barcode_shelf_ids, check_data)

    # check6(発見)
    check_list[:status_6] = check6(self.id, shelf_barcode_shelf_ids, check_data)

    # check7(製本不備)
    # システム内では、「製本済み」であり、点検データの存在する場合。
    check_list[:status_7] = check7(self.id, shelf_barcode_shelf_ids, check_data)
    
    # check8(製本中)
    check_list[:status_8] = check8(self.id, shelf_barcode_shelf_ids, check_data)

    # check9(未登録)
    check_list[:status_9] = check9(self.id)

    # 結果データの作成
    generate_check_results(self.id, check_list, shelf_barcode_shelf_ids)

    check_finish
    logger.info("end check")
  end

  #
  #
  #
  def generate_check_results(manage_id, check_list, shelf_barcode_shelf_ids)
    item_item_identifiers = Item.where(:shelf_id => shelf_barcode_shelf_ids).pluck("item_identifier")
    check_data = InventoryCheckDatum.where(:inventory_manage_id => self.id, :shelf_flag => 0).pluck(:readcode)
    merged_list = item_item_identifiers | check_data
    merged_list.sort.each do |item_identifier|
      # 書誌の名称
      original_title = ""
      item = Item.find_by_item_identifier(item_identifier)
      original_title = item.manifestation.original_title if item

      # 棚バーコード
      code_names = ""
      check_data = InventoryCheckDatum.where(:shelf_flag => 0, :readcode => item_identifier).pluck(:shelf_name)
      if check_data
        code_names = check_data.join(',')
      end

      r = InventoryCheckResult.new({:inventory_manage_id => self.id, :item_identifier => item_identifier, :original_title => original_title, :shelf_group_names => code_names})
      r.save!
    end

    %w(status_1 status_2 status_3 status_4 status_5 status_6 status_7 status_8 status_9).each do |s|
      if check_list[s.to_sym].present?
        InventoryCheckResult.update_all("#{s} = 1", ["item_identifier IN (?)", check_list[s.to_sym]])
      end
    end

  end

  # check1(所在不明)
  # システム内に存在するのに、点検データには存在しない。
  # 
  def check1(manage_id, shelf_barcode_shelf_ids)
    item_item_identifiers = Item.where(:shelf_id => shelf_barcode_shelf_ids).pluck("item_identifier")
    readcodes = InventoryCheckDatum.where(:inventory_manage_id => self.id, :shelf_flag => 0).pluck(:readcode)
    check_list = item_item_identifiers - readcodes
    return check_list
  end

  # check2(配架間違い)
  # 2-1:指定資料区分以外の資料が点検データに存在した。
  #    
  def check21(manage_id, manifestation_type_ids)
    check_list = []
    if manifestation_type_ids.present?
      readcode_items = Item.joins(:manifestation).where("item_identifier IN (?)", readcodes)
      readcode_items.each do |i|
        unless manifestation_type_ids.include?(i.manifestation.manifestation_id) 
          check_list << i
        end
      end
    end
    return check_list 
  end

  # check2(配架間違い)
  # 2-2:システム内の棚と点検データの棚が一致しない。
  #
  def check22(manage_id)
    check_list = []
    check_data = InventoryCheckDatum.where(:inventory_manage_id => self.id, :shelf_flag => 0)
    check_data.each do |datum|
      invalid_flag = true
      barcode_shelf = InventoryShelfBarcode.find_by_barcode(datum.shelf_name) 
      if barcode_shelf.try(:shelf)
        shelf = barcode_shelf.shelf
        item = Item.find_by_item_identifier(datum.readcode)
        if item.try(:shelf)
          item_shelf = item.shelf
          if item_shelf.id == shelf.id
            invalid_flag = false
          end
        end
      end
      if invalid_flag
        check_list << datum.readcode
      end
    end
    return check_list 
  end

  # check3(乱れ)
  # 棚内の請求記号１桁目で割合の少ない点検データを検出
  # 
  def check3(manage_id)
    check_list = []
    check_data = InventoryCheckDatum.where(:inventory_manage_id => manage_id, :shelf_flag => 0)
    check_data.each do |datum|

    end
    return check_list
  end

  # check4(貸出中)
  # システムでは貸出中であり、点検データには存在しない場合。
  #
  def check4(manage_id, shelf_barcode_shelf_ids, check_data)
    status_id_on_loan =  CirculationStatus.find_by_name("On Loan").id 
    checkout_item_identifiers = Item.where(:circulation_status_id => status_id_on_loan, :shelf_id => shelf_barcode_shelf_ids).pluck(:item_identifier)
    check_list = checkout_item_identifiers - check_data
    return check_list
  end


  # check5(未返却)
  # システムでは貸出中であり、点検データには存在する場合。
  #
  def check5(manage_id, shelf_barcode_shelf_ids, check_data)
    status_id_on_loan =  CirculationStatus.find_by_name("On Loan").id 
    checkout_item_identifiers = Item.where(:circulation_status_id => status_id_on_loan, :shelf_id => shelf_barcode_shelf_ids).pluck(:item_identifier)
    check_list = checkout_item_identifiers & check_data
    return check_list
  end

  # check6(発見)
  # システムでは、不明、紛失、除籍であるのに点検データに存在する場合。
  # 
  def check6(manage_id, shelf_barcode_shelf_ids, check_data)
    status_ids_on_lost = CirculationStatus.where(:name => ["Circulation Status Undefined", "Lost", "Removed"]).pluck(:id)
    lost_item_identifiers = Item.where(:circulation_status_id => status_ids_on_lost, :shelf_id => shelf_barcode_shelf_ids).pluck(:item_identifier)
    check_list = lost_item_identifiers & check_data
    return check_list
  end

  # check7(製本不備)
  # システム内では、「製本済み」であり、点検データの存在する場合。
  #
  def check7(manage_id, shelf_barcode_shelf_ids, check_data)
    status_ids_on_binded = CirculationStatus.where(:name => ["Binded"]).pluck(:id)
    binded_item_identifiers = Item.where(:circulation_status_id => status_ids_on_binded, :shelf_id => shelf_barcode_shelf_ids).pluck(:item_identifier)
    check_list = binded_item_identifiers & check_data
    return check_list
  end

  # check8(製本中)
  # システム内では、「製本または修理中」であり、点検データに存在しない場合。
  def check8(manage_id, shelf_barcode_shelf_ids, check_data)
    status_ids_in_factory = CirculationStatus.where(:name => ["In Factory"]).pluck(:id)
    in_factory_item_identifiers = Item.where(:circulation_status_id => status_ids_in_factory, :shelf_id => shelf_barcode_shelf_ids).pluck(:item_identifier)
    checklist = check_data - in_factory_item_identifiers
    return checklist
  end

  # check9(未登録)
  # システム内の所蔵情報には存在しない点検データコード。
  # 
  def check9(manage_id)
    check_data = InventoryCheckDatum.where(:inventory_manage_id => manage_id, :shelf_flag => 0).pluck(:readcode)
    item_identifiers = Item.pluck(:item_identifier)
    checklist = check_data - item_identifiers
    return checklist
  end

  def copy_shelves_to_inventory_shelves
  end

  def phase1_check
    notifications = []

    if self.inventory_shelf_barcodes.blank?
      n = OpenStruct.new
      n.message = I18n.t("inventory_page.no_have_inventory_shelf_barcode")
      notifications << n
    end
    if self.inventory_check_data.blank?
      n = OpenStruct.new
      n.message = I18n.t("inventory_page.no_have_inventory_check_data")
      notifications << n
    end
    if notifications.size == 0 && self.inventory_check_results.blank?
      n = OpenStruct.new
      n.message = I18n.t("inventory_page.no_execute_inventory_check")
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

  private
  def check_start
    self.check_started_at = Time.now
    self.check_finished_at = nil
    self.state = 7
    self.save!
  end

  def check_finish
    self.check_finished_at = Time.now
    self.state = 8
    self.save!
  end

end
