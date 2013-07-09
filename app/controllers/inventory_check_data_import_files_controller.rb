require_dependency "enju_trunk_inventory/application_controller"

class InventoryCheckDataImportFilesController < ApplicationController
  # GET /inventory_check_data_import_files
  # GET /inventory_check_data_import_files.json
  def index
    @inventory_check_data_import_files = InventoryCheckDataImportFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_check_data_import_files }
    end
  end

  # GET /inventory_check_data_import_files/1
  # GET /inventory_check_data_import_files/1.json
  def show
    @inventory_check_data_import_file = InventoryCheckDataImportFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_check_data_import_file }
    end
  end

  # GET /inventory_check_data_import_files/new
  # GET /inventory_check_data_import_files/new.json
  def new
    @inventory_check_data_import_file = InventoryCheckDataImportFile.new
    @inventory_manage_id = params[:inventory_manage_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_check_data_import_file }
    end
  end

  # GET /inventory_check_data_import_files/1/edit
  def edit
    @inventory_check_data_import_file = InventoryCheckDataImportFile.find(params[:id])
  end

  # POST /inventory_check_data_import_files
  # POST /inventory_check_data_import_files.json
  def create
    @inventory_check_data_import_file = InventoryCheckDataImportFile.new(:inventory_manage_id => params[:inventory_manage_id], :inventory_check_data_import => params[:inventory_check_data_import])
    @inventory_manage_id = params[:inventory_manage_id]


    puts "@@"
    pp @inventory_check_data_import_file

    if @inventory_check_data_import_file.save
      redirect_to @inventory_check_data_import_file, notice: 'Inventory check data import file was successfully created.' 
    else
      render action: "new" 
    end
  end

  # PUT /inventory_check_data_import_files/1
  # PUT /inventory_check_data_import_files/1.json
  def update
    @inventory_check_data_import_file = InventoryCheckDataImportFile.find(params[:id])

    respond_to do |format|
      if @inventory_check_data_import_file.update_attributes(params[:inventory_check_data_import_file])
        format.html { redirect_to @inventory_check_data_import_file, notice: 'Inventory check data import file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_check_data_import_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_check_data_import_files/1
  # DELETE /inventory_check_data_import_files/1.json
  def destroy
    @inventory_check_data_import_file = InventoryCheckDataImportFile.find(params[:id])
    @inventory_check_data_import_file.destroy

    respond_to do |format|
      format.html { redirect_to inventory_check_data_import_files_url }
      format.json { head :no_content }
    end
  end
end
