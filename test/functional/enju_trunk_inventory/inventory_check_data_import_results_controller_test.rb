require 'test_helper'

module EnjuTrunkInventory
  class InventoryCheckDataImportResultsControllerTest < ActionController::TestCase
    setup do
      @inventory_check_data_import_result = inventory_check_data_import_results(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:inventory_check_data_import_results)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create inventory_check_data_import_result" do
      assert_difference('InventoryCheckDataImportResult.count') do
        post :create, inventory_check_data_import_result: { body: @inventory_check_data_import_result.body, error_msg: @inventory_check_data_import_result.error_msg, inventory_check_data_import_file_id: @inventory_check_data_import_result.inventory_check_data_import_file_id }
      end
  
      assert_redirected_to inventory_check_data_import_result_path(assigns(:inventory_check_data_import_result))
    end
  
    test "should show inventory_check_data_import_result" do
      get :show, id: @inventory_check_data_import_result
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @inventory_check_data_import_result
      assert_response :success
    end
  
    test "should update inventory_check_data_import_result" do
      put :update, id: @inventory_check_data_import_result, inventory_check_data_import_result: { body: @inventory_check_data_import_result.body, error_msg: @inventory_check_data_import_result.error_msg, inventory_check_data_import_file_id: @inventory_check_data_import_result.inventory_check_data_import_file_id }
      assert_redirected_to inventory_check_data_import_result_path(assigns(:inventory_check_data_import_result))
    end
  
    test "should destroy inventory_check_data_import_result" do
      assert_difference('InventoryCheckDataImportResult.count', -1) do
        delete :destroy, id: @inventory_check_data_import_result
      end
  
      assert_redirected_to inventory_check_data_import_results_path
    end
  end
end
