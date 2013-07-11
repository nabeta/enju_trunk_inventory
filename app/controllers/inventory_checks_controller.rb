require_dependency "enju_trunk_inventory/application_controller"

class InventoryChecksController < ApplicationController
  def show
    @inventory_manage_id = params[:inventory_manage_id]
    @inventory_manage = InventoryManage.find(@inventory_manage_id)
    @inventory_notifications = []
  end
end
