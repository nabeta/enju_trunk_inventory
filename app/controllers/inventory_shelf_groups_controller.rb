class InventoryShelfGroupsController < ApplicationController
  # GET /inventory_shelf_groups
  # GET /inventory_shelf_groups.json
  def index
    @inventory_shelf_groups = InventoryShelfGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_shelf_groups }
    end
  end

  # GET /inventory_shelf_groups/1
  # GET /inventory_shelf_groups/1.json
  def show
    @inventory_shelf_group = InventoryShelfGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_shelf_group }
    end
  end

  # GET /inventory_shelf_groups/new
  # GET /inventory_shelf_groups/new.json
  def new
    @inventory_shelf_group = InventoryShelfGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_shelf_group }
    end
  end

  # GET /inventory_shelf_groups/1/edit
  def edit
    @inventory_shelf_group = InventoryShelfGroup.find(params[:id])
  end

  # POST /inventory_shelf_groups
  # POST /inventory_shelf_groups.json
  def create
    @inventory_shelf_group = InventoryShelfGroup.new(params[:inventory_shelf_group])

    respond_to do |format|
      if @inventory_shelf_group.save
        format.html { redirect_to @inventory_shelf_group, notice: 'Inventory shelf group was successfully created.' }
        format.json { render json: @inventory_shelf_group, status: :created, location: @inventory_shelf_group }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_shelf_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_shelf_groups/1
  # PUT /inventory_shelf_groups/1.json
  def update
    @inventory_shelf_group = InventoryShelfGroup.find(params[:id])

    respond_to do |format|
      if @inventory_shelf_group.update_attributes(params[:inventory_shelf_group])
        format.html { redirect_to @inventory_shelf_group, notice: 'Inventory shelf group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_shelf_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_shelf_groups/1
  # DELETE /inventory_shelf_groups/1.json
  def destroy
    @inventory_shelf_group = InventoryShelfGroup.find(params[:id])
    @inventory_shelf_group.destroy

    respond_to do |format|
      format.html { redirect_to inventory_shelf_groups_url }
      format.json { head :no_content }
    end
  end
end

