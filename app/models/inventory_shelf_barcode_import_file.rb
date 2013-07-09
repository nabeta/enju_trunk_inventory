class InventoryShelfBarcodeImportFile < ActiveRecord::Base
  attr_accessible :inventory_manage_id, :inventory_shelf_barcode_import, :content_type, :edit_mode, :file_hash, :import_file_name, :import_file_size, :import_updated_at, :imported_at, :note, :size, :state, :user_id

  include ImportFile

  scope :not_imported, where(:state => 'pending', :imported_at => nil)
  default_scope :order => 'id DESC'

  has_attached_file :inventory_shelf_barcode_import, :path => ":rails_root/private:url"
  validates_attachment_content_type :inventory_shelf_barcode_import, :content_type => ['text/csv', 'text/plain', 'application/octet-stream']
  validates_attachment_presence :inventory_shelf_barcode_import
  belongs_to :user, :validate => true

  has_many :inventory_shelf_barcode_import_results
  belongs_to :inventory_manage

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
    if File.exists?(inventory_shelf_barcode_import.queued_for_write[:original])
      self.file_hash = Digest::SHA1.hexdigest(File.open(inventory_shelf_barcode_import.queued_for_write[:original].path, 'rb').read)
    end
  end

  def self.import(id = nil)
    if !id.nil?
      file = InventoryShelfBarcodeImportFile.find(id) rescue nil
      file.import_start unless file.nil?
    else
      InventoryShelfBarcodeImportFile.not_imported.each do |file|
        file.import_start
      end
    end
  rescue
    logger.error "#{Time.zone.now} importing inventory_shelf_barcode failed!"
    logger.error $!
    logger.error $@
  end

  def import_start
    sm_start!
    import
  end

  def import
    self.reload
    logger.info "@@@ import start"

    num = {:shelf_barcode_imported => 0, :failed => 0}
    row_num = 2
    rows = open_import_file
    field = rows.first
    if [field['barcode'], field['group'], field['shelf_name']].reject{|field| field.to_s.strip == ""}.empty?
      raise "You should specify barcode, group or shelf_name in the first line"
    end

    InventoryShelfBarcode.delete_all("inventory_manage_id=#{self.inventory_manage_id}")

    rows.each do |row|
      next if row['dummy'].to_s.strip.present?
      import_result = InventoryShelfBarcodeImportResult.create!(:inventory_shelf_barcode_import_file => self, :body => row.fields.join("\t"))

      begin
        inventory_shelf_barcode = InventoryShelfBarcode.new
        inventory_shelf_barcode.inventory_manage_id = self.inventory_manage_id 
        inventory_shelf_barcode.shelf_id = Shelf.where('name = ?', row['shelf_name']).first if row['shelf_name'].present?
        inventory_shelf_barcode.inventory_shelf_group_id = InventoryShelfGroup.where('name = ?', row['shelf_group']).first if row['shelf_group'].present?
        if field['barcode'].present? && (row['shelf_name'].blank? || row['shelf_group'].blank?)
          inventory_shelf_barcode.barcode = field['barcode'] if field['barcode'].present? && row['shelf_name'].present? 
        else 
          inventory_shelf_barcode.barcode = row['shelf_group'] + row['shelf_name'] 
        end

        Rails.logger.debug "@@@"
        if inventory_shelf_barcode.save!
          #import_result.inventory_shelf_barcode_import_file = inventory_shelf_barcode
          num[:shelf_barcode_imported] += 1
        end
      rescue Exception => e
        Rails.logger.info $!
        Rails.logger.info $@
        import_result.error_msg = "FAIL[#{row_num}]: #{e}" 
        Rails.logger.info("shelf_barcode import failed: column #{row_num}")
        num[:failed] += 1
      end
    end
  end

  def preload
    @shelves = Shelf.all
  end

  def open_import_file
    tempfile = Tempfile.new('inventory_shelf_barcode_import_file')
    uploaded_file_path = self.inventory_shelf_barcode_import.path
    open(uploaded_file_path){|f|
      f.each{|line|
        tempfile.puts(NKF.nkf('-w -Lu', line))
      }
    }
    tempfile.close

    file = CSV.open(tempfile, :col_sep => "\t")
    header = file.first
    rows = CSV.open(tempfile, :headers => header, :col_sep => "\t")
    InventoryShelfBarcodeImportResult.create(:inventory_shelf_barcode_import_file => self, :body => header.join("\t"), :error_msg => 'HEADER DATA')
    tempfile.close(true)
    file.close
    rows
  end



end
