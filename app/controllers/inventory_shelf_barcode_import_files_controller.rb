class InventoryShelfBarcodeImportFilesController < ApplicationController
  def index
    @inventory_manage = InventoryManage.find(params[:inventory_manage_id])
    @inventory_shelf_barcode_import_files = InventoryShelfBarcodeImportFile.where(:inventory_manage_id => params[:inventory_manage_id]).page(params[:page])

  end

  def show
    @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.find(params[:id])
    puts "@@"
    puts @inventory_shelf_barcode_import_file

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_shelf_barcode_import_file }
    end
  end

  def new
    @inventory_manage_inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.new
    @inventory_manage_id = params[:inventory_manage_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_shelf_barcode_import_file }
    end
  end

  def edit
    @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.find(params[:id])
  end

  def create
    @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.new(:inventory_manage_id => params[:inventory_manage_id], :inventory_shelf_barcode_import => params[:inventory_shelf_barcode_import])
    @inventory_manage_id = params[:inventory_manage_id]

    if @inventory_shelf_barcode_import_file.save
      redirect_to @inventory_shelf_barcode_import_file, :notice => t('controller.successfully_created', :model => t('activerecord.models.inventory_shelf_barcode_import_file'))
    else
      render action: "new"
    end
  end

  def update
    @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.find(params[:id])

    respond_to do |format|
      if @inventory_shelf_barcode_import_file.update_attributes(params[:inventory_shelf_barcode_import_file])
        format.html { redirect_to @inventory_shelf_barcode_import_file, notice: 'Inventory shelf barcode import file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_shelf_barcode_import_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.find(params[:id])
    @inventory_shelf_barcode_import_file.destroy

    respond_to do |format|
      format.html { redirect_to inventory_shelf_barcode_import_files_url }
      format.json { head :no_content }
    end
  end

  def import_request
    begin
      @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.find(params[:id])
      Asynchronized_Service.new.delay.perform(:InventoryShelfBarcodeImportFile_import, @inventory_shelf_barcode_import_file.id)
      flash[:message] = t('inventory_page.inventory_barcode_import_file.import_request')
    rescue Exception => e
      logger.error "Failed to send process to delayed_job: #{e}"
    end

    redirect_to inventory_shelf_barcode_import_file_inventory_shelf_barcode_import_result_path
  end

end
