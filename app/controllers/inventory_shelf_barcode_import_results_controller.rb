class InventoryShelfBarcodeImportResultsController < ApplicationController
  # GET /inventory_shelf_barcode_import_results
  # GET /inventory_shelf_barcode_import_results.json
  def index
    @inventory_shelf_barcode_import_file_id = params[:inventory_shelf_barcode_import_file_id]
    @inventory_shelf_barcode_import_results = InventoryShelfBarcodeImportResult.where(:inventory_shelf_barcode_import_file_id => @inventory_shelf_barcode_import_file_id)
    @results_num = @inventory_shelf_barcode_import_results.length

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_shelf_barcode_import_results }
    end
  end

  # GET /inventory_shelf_barcode_import_results/1
  # GET /inventory_shelf_barcode_import_results/1.json
  def show
    @inventory_shelf_barcode_import_result = InventoryShelfBarcodeImportResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_shelf_barcode_import_result }
    end
  end

  # GET /inventory_shelf_barcode_import_results/new
  # GET /inventory_shelf_barcode_import_results/new.json
  def new
    @inventory_shelf_barcode_import_result = InventoryShelfBarcodeImportResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_shelf_barcode_import_result }
    end
  end

  # GET /inventory_shelf_barcode_import_results/1/edit
  def edit
    @inventory_shelf_barcode_import_result = InventoryShelfBarcodeImportResult.find(params[:id])
  end

  # POST /inventory_shelf_barcode_import_results
  # POST /inventory_shelf_barcode_import_results.json
  def create
    @inventory_shelf_barcode_import_result = InventoryShelfBarcodeImportResult.new(params[:inventory_shelf_barcode_import_result])

    respond_to do |format|
      if @inventory_shelf_barcode_import_result.save
        format.html { redirect_to @inventory_shelf_barcode_import_result, notice: 'Inventory shelf barcode import result was successfully created.' }
        format.json { render json: @inventory_shelf_barcode_import_result, status: :created, location: @inventory_shelf_barcode_import_result }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_shelf_barcode_import_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_shelf_barcode_import_results/1
  # PUT /inventory_shelf_barcode_import_results/1.json
  def update
    @inventory_shelf_barcode_import_result = InventoryShelfBarcodeImportResult.find(params[:id])

    respond_to do |format|
      if @inventory_shelf_barcode_import_result.update_attributes(params[:inventory_shelf_barcode_import_result])
        format.html { redirect_to @inventory_shelf_barcode_import_result, notice: 'Inventory shelf barcode import result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_shelf_barcode_import_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_shelf_barcode_import_results/1
  # DELETE /inventory_shelf_barcode_import_results/1.json
  def destroy
    @inventory_shelf_barcode_import_result = InventoryShelfBarcodeImportResult.find(params[:id])
    @inventory_shelf_barcode_import_result.destroy

    respond_to do |format|
      format.html { redirect_to inventory_shelf_barcode_import_results_url }
      format.json { head :no_content }
    end
  end
end
