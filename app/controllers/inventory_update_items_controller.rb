require 'ostruct'
class InventoryUpdateItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_librarian

  def index
  end

  def bulk_edit
    prepare_options
    @inventory_update_items = OpenStruct.new(:inventory_manage_id => @inventory_manage.id)
    @inventory_update_items.result_statuses = []
  end

  def bulk_update
  end

  def unit_edit
    prepare_options
    @inventory_update_items = OpenStruct.new(:inventory_manage_id => @inventory_manage.id)
    @inventory_update_items.item_identifier = params[:item_identifier]
    @inventory_update_items.result_statuses = []
    @item = Item.find_by_item_identifier(@inventory_update_items.item_identifier)
    unless @item
      raise "item is invalid. item_identifier=#{@inventory_update_items.item_identifier}"
    end
 
  end

  def unit_update
    @errors = []
    @item = Item.find_by_item_identifier(params[:item_identifier])
    raise ActiveRecord::RecordNotFound.new("Item not found.") unless @item
    #check_datum = InventoryCheckDatum.where(:barcode => params[:item_identifier])
    check_datum = InventoryCheckResult.find_by_item_identifier(params[:item_identifier])
    raise ActiveRecord::RecordNotFound.new("Check_data not found.") unless check_datum

    prepare_options
    @inventory_update_items = OpenStruct.new(:inventory_manage_id => @inventory_manage.id)
    @inventory_update_items.item_identifier = params[:item_identifier]
    @inventory_update_items.result_statuses = []
    @inventory_update_items.shelf = params[:shelf]
    @inventory_update_items.circulation_status = params[:circulation_status]
 
    item_update = {}
    if params[:shelf].present?
      shelf = Shelf.find_by_name(params[:shelf])
      unless shelf
        @errors << I18n.t('activerecord.attributes.inventory_update_items.invalid_input_shelf')
        render action: "unit_edit" 
        return
      end
      item_update[:shelf] = shelf
    end
    if params[:circulation_status].present?
      circulation_status = CirculationStatus.find(params[:circulation_status])
      unless circulation_status
        @errors << I18n.t('activerecord.attributes.inventory_update_items.invalid_input_circulation_status')
        render action: "unit_edit" 
        return
      end
      item_update[:circulation_status_id] = circulation_status
 
    end
    if item_update.present?
      puts item_update
      @item.update_attributes(item_update)
    end

    if params[:skip_flag].present?
      puts "@@@999"
      check_datum.skip_flag = 1
      check_datum.save!
    end

    flash[:notice] =  I18n.t('activerecord.attributes.inventory_update_items.success_update')
    redirect_to inventory_manage_inventory_check_results_path
  end

  private
  def prepare_options
    @inventory_manage = InventoryManage.find(params[:inventory_manage_id])

    @result_status = []
    %w(1 2 3 4 5 6 7 8).each do |c|
      s = OpenStruct.new
      s.id = c
      s.display_name = I18n.t("activerecord.attributes.inventory_check_result.status_#{c}")
      @result_status << s
    end

    @inventory_shelf_barcodes = @inventory_manage.inventory_shelf_barcodes
  end
end
