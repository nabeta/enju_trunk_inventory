class InventoryCheckDataImportFile < ActiveRecord::Base
  attr_accessible :inventory_manage_id, :inventory_check_data_import, :content_type, :edit_mode, :file_hash, :import_file_name, :import_file_size, :import_updated_at, :imported_at, :note, :size, :state, :user_id

  include ImportFile

  scope :not_imported, where(:state => 'pending', :imported_at => nil)
  default_scope :order => 'id DESC'

  has_attached_file :inventory_check_data_import, :path => ":rails_root/private:url"
  validates_attachment_content_type :inventory_check_data_import, :content_type => ['text/csv', 'text/plain', 'application/octet-stream']
  validates_attachment_presence :inventory_check_data_import
  belongs_to :user, :validate => true
  has_many :inventory_check_data_import_results

  validates :edit_mode, :presence => true

  before_create :set_digest

  state_machine :initial => :pending do
    event :sm_start do
      transition [:pending, :started] => :started
    end

    event :sm_complete do
      transition :started => :completed
    end

    event :sm_fail do
      transition :started => :failed
    end
  end

  def set_digest(options = {:type => 'sha1'})
    if File.exists?(inventory_check_data_import.queued_for_write[:original])
      self.file_hash = Digest::SHA1.hexdigest(File.open(inventory_check_data_import.queued_for_write[:original].path, 'rb').read)
    end
  end

  def self.import(id = nil)
    if !id.nil?
      file = InventoryCheckDataImportFile.find(id) rescue nil
      file.import_start unless file.nil?
    else
      InventoryCheckDataImportFile.not_imported.each do |file|
        file.import_start
      end
    end
  rescue
    logger.error "#{Time.zone.now} importing inventory_check_data failed!"
    logger.error $!
    logger.error $@
  end

  def import_start
    sm_start!
    import
  end

  def import
    self.reload

    logger.info "#{Time.zone.now} importing inventory_check_data start"

    row_num = 0
    num = {:shelf_check_data_imported => 0, :failed => 0}
    filename = self.inventory_check_data_import.path

    edit_mode_flag = :replace_by_shelf    # replace by shelf
    if self.edit_mode == 'update'
      edit_mode_flag = :replace_by_item   # replace by item
    end

    logger.info "#{Time.zone.now} importing filename=#{filename}"

    shelf_barcodes = InventoryShelfBarcode.pluck(:barcode)
    shelf_name = ""

    open(filename, "rb") do |f|
      CSV.new(f).each do |row|
        row_num = row_num + 1
        logger.info "#{Time.zone.now} importing @@@1"
        logger.info "#{Time.zone.now} importing @@@2 row=#{row} row.class=#{row.class}"

        next if row.blank?
        readcode = ""
        readcode = row.first if row.class == Array

        logger.info "#{Time.zone.now} importing @@@10"
        logger.info "#{Time.zone.now} importing @@@11 readcode=#{readcode}"

        import_result = InventoryCheckDataImportResult.create!(:inventory_check_data_import_file => self, :body => row)

        begin
          inventory_check_datum = InventoryCheckDatum.new

          if shelf_barcodes.include?(readcode)
            if edit_mode_flag == :replace_by_shelf
              if shelf_name != readcode 
              # 棚コードの終わりの場合は削除しない。
                InventoryCheckDatum.delete_all(['inventory_manage_id = ? and shelf_name = ?', self.inventory_manage_id, readcode])
              end
            end

            inventory_check_datum.shelf_flag = 1 
            shelf_name = readcode
          end

          inventory_check_datum.inventory_manage_id = self.inventory_manage_id 
          inventory_check_datum.readcode = readcode
          inventory_check_datum.shelf_name = shelf_name if shelf_name.present?

          if edit_mode_flag == :replace_by_item
            InventoryCheckDatum.delete_all(['inventory_manage_id = ? and readcode = ? and shelf_name = ?', self.inventory_manage_id, readcode, shelf_name])
          end

          if inventory_check_datum.save!
            #import_result.inventory_shelf_barcode_import_file = inventory_shelf_barcode
            num[:shelf_check_data_imported] += 1
          end
        rescue Exception => e
          logger.info $!
          logger.info $@
          import_result.error_msg = "FAIL[#{row_num}]: #{e}"
          logger.info("check_data import failed: column #{row_num}")
          num[:failed] += 1
        end

      end
    end

    self.update_attribute(:imported_at, Time.zone.now)
    sm_complete!
    return num
  end


end
