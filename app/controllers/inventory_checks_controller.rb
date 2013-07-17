require_dependency "enju_trunk_inventory/application_controller"

class InventoryChecksController < ApplicationController

  def create 
    # import_request
    begin
      @inventory_manage = InventoryManage.find(params[:inventory_manage_id])
      Asynchronized_Service.new.delay.perform(:InventoryCheck_exec, @inventory_manage.id)
      flash[:message] = t('inventory_check.start')
    rescue Exception => e
      logger.error "Failed to send process to delayed_job: #{e}"
    end
    logger.info "inventory_create :id=#{@inventory_manage.id}"
    redirect_to @inventory_manage
  end

  def new
    @inventory_manage_id = params[:inventory_manage_id]
    @inventory_manage = InventoryManage.find(@inventory_manage_id)
    @inventory_notifications = []
  end

  def show
    @inventory_manage_id = params[:inventory_manage_id]
    @inventory_manage = InventoryManage.find(@inventory_manage_id)
    @inventory_notifications = []
  end
end
