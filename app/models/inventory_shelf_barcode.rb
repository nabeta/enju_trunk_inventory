class InventoryShelfBarcode < ActiveRecord::Base
  include ActionView::Helpers::TranslationHelper
  attr_accessible :barcode

  default_scope order('barcode')

  belongs_to :inventory_manage

  def self.csv(barcodes)
    require 'csv'
    headers = []
    headers << I18n.t('activerecord.attributes.inventory_shelf_barcode.barcode') 
    headers << I18n.t('activerecord.attributes.inventory_shelf_barcode.inventory_shelf_group') 
    headers << I18n.t('activerecord.attributes.inventory_shelf_barcode.shelf') 
    headers << I18n.t('activerecord.attributes.inventory_shelf_barcode.created_at') 
    # force_quotesオプションで全fieldにクオート強制される
    csv_data = CSV.generate(headers: headers, write_headers: true, force_quotes: false) do |csv|
      enum = if barcodes.is_a?(Array)
               barcodes.each
             else
               # Relationとかだったらfind_in_batchesで分割して
               Enumerator.new do |yielder|
                 barcodes.find_in_batches do |records|
                   records.each { |record| yielder.yield record }
                 end
               end
             end
      enum.each do |b|
        csv << [
          b.barcode,
          b.inventory_shelf_group_id,
          b.shelf_id,
          I18n.l(b.created_at)
        ]
      end
    end
    csv_data.encode(Encoding::SJIS) 
  end

  def bulk_insert_from_shelves(manage_id, prefix)
  end
end
