class InventoryCheckDataController < ApplicationController
  # GET /inventory_check_data
  # GET /inventory_check_data.json
  def index
    @inventory_manage_id = params[:inventory_manage_id]
    @inventory_manage = InventoryManage.find(@inventory_manage_id)
    @inventory_check_datum = InventoryCheckDatum.where(:inventory_manage_id => @inventory_manage_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_check_data }
    end
  end

  # GET /inventory_check_data/1
  # GET /inventory_check_data/1.json
  def show
    @inventory_check_data = InventoryCheckDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_check_datum }
    end
  end

  # GET /inventory_check_data/new
  # GET /inventory_check_data/new.json
  def new
    @inventory_manage_id = params[:inventory_manage_id]
    @inventory_manage = InventoryManage.find(@inventory_manage_id)
    @inventory_check_datum = InventoryCheckDatum.new(:inventory_manage_id => @inventory_manage_id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_check_datum }
    end
  end

  # GET /inventory_check_data/1/edit
  def edit
    @inventory_check_data = InventoryCheckDatum.find(params[:id])
  end

  # POST /inventory_check_data
  # POST /inventory_check_data.json
  def create
    @inventory_check_datum = InventoryCheckDatum.new(params[:inventory_check_datum])
    @inventory_manage = InventoryManage.find(@inventory_check_datum.id)

    if @inventory_check_datum.save
      redirect_to [@inventory_manage, @inventory_check_datum], notice: 'Inventory check datum was successfully created.' 
    else
      render action: "new" 
    end
  end

  # PUT /inventory_check_data/1
  # PUT /inventory_check_data/1.json
  def update
    @inventory_check_data = InventoryCheckDatum.find(params[:id])

    respond_to do |format|
      if @inventory_check_data.update_attributes(params[:inventory_check_data])
        format.html { redirect_to @inventory_check_datum, notice: 'Inventory check datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_check_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_check_data/1
  # DELETE /inventory_check_data/1.json
  def destroy
    @inventory_check_datum = InventoryCheckDatum.find(params[:id])
    @inventory_check_datum.destroy

    redirect_to inventory_manage_inventory_check_data_url
  end
end
