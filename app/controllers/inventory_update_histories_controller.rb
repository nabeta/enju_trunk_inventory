class InventoryUpdateHistoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_librarian

  def index
    @inventory_manage = InventoryManage.find(params[:inventory_manage_id])
    @histories = InventoryUpdateHistory.where(:inventory_manage_id => params[:inventory_manage_id])
  end

  def show
    @inventory_manage = InventoryManage.find(params[:inventory_manage_id])
    @inventory_update_history = InventoryUpdateHistory.find(params[:id])
  end
end
