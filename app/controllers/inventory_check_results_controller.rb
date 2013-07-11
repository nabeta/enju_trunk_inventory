require_dependency "enju_trunk_inventory/application_controller"

module EnjuTrunkInventory
  class InventoryCheckResultsController < ApplicationController
    # GET /inventory_check_results
    # GET /inventory_check_results.json
    def index
      @inventory_check_results = InventoryCheckResult.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @inventory_check_results }
      end
    end
  
    # GET /inventory_check_results/1
    # GET /inventory_check_results/1.json
    def show
      @inventory_check_result = InventoryCheckResult.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @inventory_check_result }
      end
    end
  
    # GET /inventory_check_results/new
    # GET /inventory_check_results/new.json
    def new
      @inventory_check_result = InventoryCheckResult.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @inventory_check_result }
      end
    end
  
    # GET /inventory_check_results/1/edit
    def edit
      @inventory_check_result = InventoryCheckResult.find(params[:id])
    end
  
    # POST /inventory_check_results
    # POST /inventory_check_results.json
    def create
      @inventory_check_result = InventoryCheckResult.new(params[:inventory_check_result])
  
      respond_to do |format|
        if @inventory_check_result.save
          format.html { redirect_to @inventory_check_result, notice: 'Inventory check result was successfully created.' }
          format.json { render json: @inventory_check_result, status: :created, location: @inventory_check_result }
        else
          format.html { render action: "new" }
          format.json { render json: @inventory_check_result.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /inventory_check_results/1
    # PUT /inventory_check_results/1.json
    def update
      @inventory_check_result = InventoryCheckResult.find(params[:id])
  
      respond_to do |format|
        if @inventory_check_result.update_attributes(params[:inventory_check_result])
          format.html { redirect_to @inventory_check_result, notice: 'Inventory check result was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @inventory_check_result.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /inventory_check_results/1
    # DELETE /inventory_check_results/1.json
    def destroy
      @inventory_check_result = InventoryCheckResult.find(params[:id])
      @inventory_check_result.destroy
  
      respond_to do |format|
        format.html { redirect_to inventory_check_results_url }
        format.json { head :no_content }
      end
    end
  end
end
