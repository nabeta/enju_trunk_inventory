require_dependency "enju_trunk_inventory/application_controller"

class InventoryCheckResultsController < ApplicationController
  def index
    @inventory_manage = InventoryManage.find(params[:inventory_manage_id])
    @inventory_check_results = InventoryCheckResult.where(:inventory_manage_id => params[:inventory_manage_id])
    @status_type_selected = []
    @item_identifier = ""
    if params[:status_types].present?
      @status_type_selected = params[:status_types].keys
      c = []
      params[:status_types].keys.each do |k|
        if k =~ /\d+/ and k != "0"
          c <<  "status_#{k} = 1"
        end
      end
      if @status_type_selected.include?("0")
        output_status_green_condition = true
        c << "(status_1 = 0 and status_2 = 0 and status_3 = 0 and status_4 = 0 and status_5 = 0 and status_6 = 0 and status_7 = 0 and status_8 = 0 and status_9 = 0)"
      end
      append_sql = "(" + c.join(" OR ") + ")"
      @inventory_check_results = @inventory_check_results.where(append_sql)
    end
    if params[:item_identifier].present?
      @item_identifier = params[:item_identifier]
      q = "%#{@item_identifier}%"
      @inventory_check_results = @inventory_check_results.where(["item_identifier like ?", q])
    end

    if params[:output_check_error_list] || params[:output_check_list]
      send_data InventoryCheckResult.get_result_list_tsv(@inventory_check_results, params) , :filename => "inventory_check_resul"
      return
    end

    prepare

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_check_results }
    end
  end

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

  def prepare
    @status_types = []
    for n in (0..9)
      s = OpenStruct.new({:id => n, :display_name => I18n.t("activerecord.attributes.inventory_check_result.status_#{n}")})
      @status_types << s
    end
  end
end
