class InventoryShelfBarcodeImportResultsController < ApplicationController
  def index
    @inventory_shelf_barcode_import_file_id = params[:inventory_shelf_barcode_import_file_id]
    @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.find(@inventory_shelf_barcode_import_file_id)
    @inventory_shelf_barcode_import_results = InventoryShelfBarcodeImportResult.where(:inventory_shelf_barcode_import_file_id => @inventory_shelf_barcode_import_file_id)
    @results_num = @inventory_shelf_barcode_import_results.length

  end

  def show
    @inventory_shelf_barcode_import_result = InventoryShelfBarcodeImportResult.find(params[:id])

  end

end
