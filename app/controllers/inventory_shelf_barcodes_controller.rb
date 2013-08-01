class InventoryShelfBarcodesController < ApplicationController
  # GET /inventory_shelf_barcodes
  # GET /inventory_shelf_barcodes.json
  def index
    @inventory_manage_id = params[:inventory_manage_id]
    @inventory_manage = InventoryManage.find(@inventory_manage_id)
    @inventory_shelf_barcodes = InventoryShelfBarcode.where(:inventory_manage_id => @inventory_manage_id)

    respond_to do |format|
      format.html # index.html.erb
      format.csv  { send_data InventoryShelfBarcode.csv(@inventory_shelf_barcodes), type: 'text/csv; charset=shift_jis', filename: "hoge.csv" }
      format.json { render json: @inventory_shelf_barcodes }
    end
  end

  # GET /inventory_shelf_barcodes/1
  # GET /inventory_shelf_barcodes/1.json
  def show
    @inventory_shelf_barcode = InventoryShelfBarcode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_shelf_barcode }
    end
  end

  # GET /inventory_shelf_barcodes/new
  # GET /inventory_shelf_barcodes/new.json
  def new
    @inventory_shelf_barcode = InventoryShelfBarcode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_shelf_barcode }
    end
  end

  # GET /inventory_shelf_barcodes/1/edit
  def edit
    @inventory_shelf_barcode = InventoryShelfBarcode.find(params[:id])
  end

  # POST /inventory_shelf_barcodes
  # POST /inventory_shelf_barcodes.json
  def create
    @inventory_shelf_barcode = InventoryShelfBarcode.new(params[:inventory_shelf_barcode])

    respond_to do |format|
      if @inventory_shelf_barcode.save
        format.html { redirect_to @inventory_shelf_barcode, notice: 'Inventory shelf barcode was successfully created.' }
        format.json { render json: @inventory_shelf_barcode, status: :created, location: @inventory_shelf_barcode }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_shelf_barcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_shelf_barcodes/1
  # PUT /inventory_shelf_barcodes/1.json
  def update
    @inventory_shelf_barcode = InventoryShelfBarcode.find(params[:id])

    respond_to do |format|
      if @inventory_shelf_barcode.update_attributes(params[:inventory_shelf_barcode])
        format.html { redirect_to @inventory_shelf_barcode, notice: 'Inventory shelf barcode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_shelf_barcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_shelf_barcodes/1
  # DELETE /inventory_shelf_barcodes/1.json
  def destroy
    @inventory_shelf_barcode = InventoryShelfBarcode.find(params[:id])
    @inventory_shelf_barcode.destroy

    respond_to do |format|
      format.html { redirect_to inventory_shelf_barcodes_url }
      format.json { head :no_content }
    end
  end
end

