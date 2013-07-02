require 'test_helper'

module EnjuTrunkInventory
  class InventoryCheckResultsControllerTest < ActionController::TestCase
    setup do
      @inventory_check_result = inventory_check_results(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:inventory_check_results)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create inventory_check_result" do
      assert_difference('InventoryCheckResult.count') do
        post :create, inventory_check_result: { inventory_manage_id: @inventory_check_result.inventory_manage_id, status_1: @inventory_check_result.status_1, status_2: @inventory_check_result.status_2, status_3: @inventory_check_result.status_3, status_4: @inventory_check_result.status_4, status_5: @inventory_check_result.status_5, status_6: @inventory_check_result.status_6, status_7: @inventory_check_result.status_7, status_8: @inventory_check_result.status_8, status_9: @inventory_check_result.status_9 }
      end
  
      assert_redirected_to inventory_check_result_path(assigns(:inventory_check_result))
    end
  
    test "should show inventory_check_result" do
      get :show, id: @inventory_check_result
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @inventory_check_result
      assert_response :success
    end
  
    test "should update inventory_check_result" do
      put :update, id: @inventory_check_result, inventory_check_result: { inventory_manage_id: @inventory_check_result.inventory_manage_id, status_1: @inventory_check_result.status_1, status_2: @inventory_check_result.status_2, status_3: @inventory_check_result.status_3, status_4: @inventory_check_result.status_4, status_5: @inventory_check_result.status_5, status_6: @inventory_check_result.status_6, status_7: @inventory_check_result.status_7, status_8: @inventory_check_result.status_8, status_9: @inventory_check_result.status_9 }
      assert_redirected_to inventory_check_result_path(assigns(:inventory_check_result))
    end
  
    test "should destroy inventory_check_result" do
      assert_difference('InventoryCheckResult.count', -1) do
        delete :destroy, id: @inventory_check_result
      end
  
      assert_redirected_to inventory_check_results_path
    end
  end
end
