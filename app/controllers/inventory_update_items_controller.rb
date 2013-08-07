require 'ostruct'
class InventoryUpdateItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_librarian

  def bulk_edit
    prepare_options
    @bulk_update_form = OpenStruct.new
  end

  def bulk_update
    @errors = []
    @bulk_update_form = OpenStruct.new
    @bulk_update_form.shelf_barcode = params[:shelf_barcode]
    @bulk_update_form.result_status = params[:result_status]
    @bulk_update_form.shelf_name = params[:shelf_name]
    @bulk_update_form.circulation_status = params[:circulation_status]
    @bulk_update_form.skip_flag = params[:skip_flag]

    prepare_options

    item_update = {}
    if params[:shelf_barcode].blank?
      @errors << I18n.t('activerecord.attributes.inventory_update_items.invalid_no_input_shelf_barcode')
    end
    if params[:result_status].blank?
      @errors << I18n.t('activerecord.attributes.inventory_update_items.invalid_no_result_status')
    else
      unless params[:result_status] =~ /^[0-9]+$/
        @errors << I18n.t('activerecord.attributes.inventory_update_items.invalid_result_status')
      end
    end

    if @errors.size > 0
      render action: "bulk_edit" 
      return
    end

    shelf_barcode = @bulk_update_form.shelf_barcode
    result_status = @bulk_update_form.result_status
    logger.info "key: shelf_barcode=#{shelf_barcode} result_status=#{result_status}"
    
    # check-2
    item_update = {}
    if params[:shelf_name].present?
      shelf = Shelf.find_by_name(params[:shelf_name])
      unless shelf
        @errors << I18n.t('activerecord.attributes.inventory_update_items.invalid_input_shelf')
      else
        item_update[:shelf] = shelf
      end
    end
    if params[:circulation_status].present?
      circulation_status = CirculationStatus.find(params[:circulation_status])
      unless circulation_status
        @errors << I18n.t('activerecord.attributes.inventory_update_items.invalid_input_circulation_status')
      else
        item_update[:circulation_status_id] = circulation_status
      end
    end

    if item_update.blank? && params[:skip_flag].blank?
      @errors << I18n.t('activerecord.attributes.inventory_update_items.no_input')
    end

    if @errors.size > 0
      render action: "bulk_edit" 
      return
    end

    # fetch item by condition
    append_sql = "status_#{params[:result_status]} = 1" 

pp @inventory_shelf_barcodes
    shelf_group = @inventory_shelf_barcodes.find {|s| s.id.to_s == shelf_barcode }
    records = InventoryCheckResult.where(:inventory_manage_id => @inventory_manage.id, :shelf_group_names => shelf_group.barcode)
    records = records.where(append_sql)

    ActiveRecord::Base.transaction do
      records.each do |record|
        if item_update.present?
          item = Item.find_by_item_identifier()
          history = InventoryUpdateHistory.new
          history.inventory_manage_id = params[:inventory_manage_id]
          history.item_identifier = item.item_identifier
          history.before_item = @item.to_json
          #history.diffparam = {:item => item_update.to_json, :skip_flag => params[:skip_flag]}
          history.diffparam = {:item => item_update.to_json, :skip_flag => params[:skip_flag]}
          history.save!

          item.update_attributes!(item_update)
        end

        if params[:skip_flag].present?
          r = InventoryCheckDataSkip.find_or_initialize_by_inventory_manage_id_and_item_identifier({inventory_manage_id: @inventory_manage.id, item_identifier: record.item_identifier})
          r.update_attributes!(:created_by => current_user.id)
        end
      end
    end

    flash[:notice] =  I18n.t('activerecord.attributes.inventory_update_items.success_update') + " " + I18n.t('inventory_page.update_count', {count: records.count}) 
    redirect_to inventory_manage_inventory_check_results_path
  end

  def unit_edit
    prepare_options

    @item = Item.find_by_item_identifier(@inventory_update_items.item_identifier)
    unless @item
      @item = Item.new
    end
 
  end

  def unit_update
    prepare_options
    raise ActiveRecord::RecordNotFound.new("Check_data not found.") unless @inventory_check_datum

    @errors = []
    @item = Item.find_by_item_identifier(params[:item_identifier])
    unless @item
      @item = Item.new
    end

    item_update = {}
    if params[:shelf].present?
      shelf = Shelf.find_by_name(params[:shelf])
      unless shelf
        @errors << I18n.t('activerecord.attributes.inventory_update_items.invalid_input_shelf')
      else
        item_update[:shelf] = shelf
      end
    end
    if params[:circulation_status].present?
      circulation_status = CirculationStatus.find(params[:circulation_status])
      unless circulation_status
        @errors << I18n.t('activerecord.attributes.inventory_update_items.invalid_input_circulation_status')
      else
        item_update[:circulation_status_id] = circulation_status
      end
    end

    if @errors.size > 0
      render action: "unit_edit" 
      return
    end

    inventory_manage_id = params[:inventory_manage_id]
    item_identifier = params[:item_identifier]

    ActiveRecord::Base.transaction do
      if item_update.present?
        @item.update_attributes(item_update)
      end

      if params[:skip_flag].present?
        InventoryCheckDataSkip.create!(:inventory_manage_id => inventory_manage_id, :item_identifier => item_identifier, :created_by => current_user.id)
      end

      history = InventoryUpdateHistory.new
      history.inventory_manage_id = inventory_manage_id
      history.item_identifier = item_identifier
      history.before_item = @item.to_json
      history.diffparam = {:item => item_update.to_json, :skip_flag => params[:skip_flag]}
      history.save!
    end

    flash[:notice] =  I18n.t('activerecord.attributes.inventory_update_items.success_update')
    redirect_to inventory_manage_inventory_check_results_path
  end

  private
  def prepare_check
  end

  def prepare_options
    @inventory_manage = InventoryManage.find(params[:inventory_manage_id])
    @inventory_manage_id = @inventory_manage.id
    @inventory_check_datum = InventoryCheckDatum.where(:inventory_manage_id => params[:inventory_manage_id], :readcode => params[:item_identifier]).first
    @inventory_check_result = InventoryCheckResult.where(:inventory_manage_id => params[:inventory_manage_id], :item_identifier => params[:item_identifier]).first

    @result_status = []
    %w(1 2 3 4 5 6 7 8 9).each do |c|
      s = OpenStruct.new
      s.id = c
      s.display_name = I18n.t("activerecord.attributes.inventory_check_result.status_#{c}")
      @result_status << s
    end

    @inventory_shelf_barcodes = @inventory_manage.inventory_shelf_barcodes

    @inventory_update_items = OpenStruct.new(:inventory_manage_id => @inventory_manage.id)
    @inventory_update_items.item_identifier = params[:item_identifier]
    @inventory_update_items.result_statuses = []
    @inventory_update_items.shelf = params[:shelf]
    @inventory_update_items.circulation_status = params[:circulation_status]
 
  end
end
