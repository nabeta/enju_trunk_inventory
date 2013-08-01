class InventoryShelfBarcodeImportFilesController < ApplicationController
  # GET /inventory_shelf_barcode_import_files
  # GET /inventory_shelf_barcode_import_files.json
  def index
    @inventory_shelf_barcode_import_files = InventoryShelfBarcodeImportFile.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_shelf_barcode_import_files }
    end
  end

  # GET /inventory_shelf_barcode_import_files/1
  # GET /inventory_shelf_barcode_import_files/1.json
  def show
    @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.find(params[:id])
    puts "@@"
    puts @inventory_shelf_barcode_import_file

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_shelf_barcode_import_file }
    end
  end

  # GET /inventory_shelf_barcode_import_files/new
  # GET /inventory_shelf_barcode_import_files/new.json
  def new
    @inventory_manage_inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.new
    @inventory_manage_id = params[:inventory_manage_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_shelf_barcode_import_file }
    end
  end

  # GET /inventory_shelf_barcode_import_files/1/edit
  def edit
    @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.find(params[:id])
  end

  # POST /inventory_shelf_barcode_import_files
  # POST /inventory_shelf_barcode_import_files.json
  def create
    @inventory_shelf_barcode_import_file = InventoryShelfBarcodeImportFile.new(:inventory_manage_id => params[:inventory_manage_id], :inventory_shelf_barcode_import => params[:inventory_shelf_barcode_import])
    @inventory_manage_id = params[:inventory_manage_id]

    respond_to do |format|
      if @inventory_shelf_barcode_import_file.save
        format.html { redirect_to @inventory_shelf_barcode_import_file, notice: 'Inventory shelf barcode import file was successfully created.' }
        format.json { render json: @inventory_shelf_barcode_import_file, status: :created, location: @inventory_shelf_barcode_import_file }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_shelf_barcode_import_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_shelf_barcode_import_files/1
  # PUT /inventory_shelf_barcode_import_files/1.json
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

  # DELETE /inventory_shelf_barcode_import_files/1
  # DELETE /inventory_shelf_barcode_import_files/1.json
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
      flash[:message] = t('resource_import_textfile.start_importing')
    rescue Exception => e
      logger.error "Failed to send process to delayed_job: #{e}"
    end
    respond_to do |format|
      format.html {redirect_to(resource_import_textfile_resource_import_textresults_path(@resource_import_textfile))}
    end
  end

end
