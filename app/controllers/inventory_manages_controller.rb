require_dependency "enju_trunk_inventory/application_controller"

class InventoryManagesController < ApplicationController
  # GET /inventory_manages
  # GET /inventory_manages.json
  def index
    @inventory_manages = InventoryManage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_manages }
    end
  end

  # GET /inventory_manages/1
  # GET /inventory_manages/1.json
  def show
    @inventory_manage = InventoryManage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_manage }
    end
  end

  # GET /inventory_manages/new
  # GET /inventory_manages/new.json
  def new
    @inventory_manage = InventoryManage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_manage }
    end
  end

  # GET /inventory_manages/1/edit
  def edit
    @inventory_manage = InventoryManage.find(params[:id])
  end

  # POST /inventory_manages
  # POST /inventory_manages.json
  def create
    @inventory_manage = InventoryManage.new(params[:inventory_manage])

    respond_to do |format|
      if @inventory_manage.save
        format.html { redirect_to @inventory_manage, notice: 'Inventory manage was successfully created.' }
        format.json { render json: @inventory_manage, status: :created, location: @inventory_manage }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_manage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_manages/1
  # PUT /inventory_manages/1.json
  def update
    @inventory_manage = InventoryManage.find(params[:id])

    respond_to do |format|
      if @inventory_manage.update_attributes(params[:inventory_manage])
        format.html { redirect_to @inventory_manage, notice: 'Inventory manage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_manage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_manages/1
  # DELETE /inventory_manages/1.json
  def destroy
    @inventory_manage = InventoryManage.find(params[:id])
    @inventory_manage.destroy

    respond_to do |format|
      format.html { redirect_to inventory_manages_url }
      format.json { head :no_content }
    end
  end
end

