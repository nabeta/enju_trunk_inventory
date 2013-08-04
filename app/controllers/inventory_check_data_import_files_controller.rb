class InventoryCheckDataImportFilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_librarian

  def index
    prepare_options
    @inventory_check_data_import_files = InventoryCheckDataImportFile.where(:inventory_manage_id => params[:inventory_manage_id]).page(params[:page])

  end

  def show
    @inventory_check_data_import_file = InventoryCheckDataImportFile.find(params[:id])
    @inventory_manage_id = @inventory_check_data_import_file.inventory_manage_id

  end

  def new
    prepare_options
    @inventory_check_data_import_file = InventoryCheckDataImportFile.new(:edit_mode => 'create')

  end

  def edit
    @inventory_check_data_import_file = InventoryCheckDataImportFile.find(params[:id])
  end

  def create
    prepare_options
    @inventory_check_data_import_file = InventoryCheckDataImportFile.new(:inventory_manage_id => params[:inventory_manage_id], :inventory_check_data_import => params[:inventory_check_data_import], :edit_mode => params[:inventory_check_data_import_file_edit_mode])

    if @inventory_check_data_import_file.save
      redirect_to @inventory_check_data_import_file, :notice => t('controller.successfully_created', :model => t('activerecord.models.inventory_check_data_import_file'))
    else
      render action: "new" 
    end
  end

  def update
    @inventory_check_data_import_file = InventoryCheckDataImportFile.find(params[:id])

    if @inventory_check_data_import_file.update_attributes(params[:inventory_check_data_import_file])
      redirect_to @inventory_check_data_import_file, notice: 'Inventory check data import file was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  def destroy
    @inventory_check_data_import_file = InventoryCheckDataImportFile.find(params[:id])
    @inventory_check_data_import_file.destroy

    respond_to do |format|
      format.html { redirect_to inventory_check_data_import_files_url }
      format.json { head :no_content }
    end
  end

  def import_request
    begin
      @inventory_check_data_import_file = InventoryCheckDataImportFile.find(params[:id])
      @inventory_manage = InventoryManage.find(@inventory_check_data_import_file.inventory_manage_id)
      Asynchronized_Service.new.delay.perform(:InventoryCheckDataImportFile_import, @inventory_check_data_import_file.id)
      flash[:message] = t('inventory_page.inventory_check_data_import_file.import_request')
    rescue Exception => e
      logger.error "Failed to send process to delayed_job: #{e}"
    end

    redirect_to inventory_check_data_import_file_inventory_check_data_import_results_path(@inventory_check_data_import_file)
  end

  private
  def prepare_options
    @inventory_manage_id = params[:inventory_manage_id]
    @inventory_manage = InventoryManage.find(@inventory_manage_id)

    @edit_modes = []
    @edit_modes << OpenStruct.new(:display_name => t('page.create'), :name => 'create')
    @edit_modes << OpenStruct.new(:display_name => t('page.update'), :name => 'update')
  end
end
