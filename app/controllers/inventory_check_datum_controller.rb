require_dependency "enju_trunk_inventory/application_controller"

class InventoryCheckDatumController < ApplicationController
  # GET /inventory_check_data
  # GET /inventory_check_data.json
  def index
    @inventory_check_datum = InventoryCheckData.all
    @inventory_manage_id = params[:inventory_manage_id]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_check_data }
    end
  end

  # GET /inventory_check_data/1
  # GET /inventory_check_data/1.json
  def show
    @inventory_check_data = InventoryCheckData.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_check_datum }
    end
  end

  # GET /inventory_check_data/new
  # GET /inventory_check_data/new.json
  def new
    @inventory_check_data = InventoryCheckData.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_check_datum }
    end
  end

  # GET /inventory_check_data/1/edit
  def edit
    @inventory_check_data = InventoryCheckData.find(params[:id])
  end

  # POST /inventory_check_data
  # POST /inventory_check_data.json
  def create
    @inventory_check_data = InventoryCheckData.new(params[:inventory_check_data])

    respond_to do |format|
      if @inventory_check_datum.save
        format.html { redirect_to @inventory_check_datum, notice: 'Inventory check datum was successfully created.' }
        format.json { render json: @inventory_check_datum, status: :created, location: @inventory_check_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_check_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_check_data/1
  # PUT /inventory_check_data/1.json
  def update
    @inventory_check_data = InventoryCheckData.find(params[:id])

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

    respond_to do |format|
      format.html { redirect_to inventory_check_data_url }
      format.json { head :no_content }
    end
  end
end
