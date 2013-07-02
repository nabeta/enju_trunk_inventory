require 'test_helper'

module EnjuTrunkInventory
  class InventoryCheckDataControllerTest < ActionController::TestCase
    setup do
      @inventory_check_datum = inventory_check_data(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:inventory_check_data)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create inventory_check_datum" do
      assert_difference('InventoryCheckDatum.count') do
        post :create, inventory_check_datum: { inventory_manage_id: @inventory_check_datum.inventory_manage_id, read_at: @inventory_check_datum.read_at, readcode: @inventory_check_datum.readcode }
      end
  
      assert_redirected_to inventory_check_datum_path(assigns(:inventory_check_datum))
    end
  
    test "should show inventory_check_datum" do
      get :show, id: @inventory_check_datum
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @inventory_check_datum
      assert_response :success
    end
  
    test "should update inventory_check_datum" do
      put :update, id: @inventory_check_datum, inventory_check_datum: { inventory_manage_id: @inventory_check_datum.inventory_manage_id, read_at: @inventory_check_datum.read_at, readcode: @inventory_check_datum.readcode }
      assert_redirected_to inventory_check_datum_path(assigns(:inventory_check_datum))
    end
  
    test "should destroy inventory_check_datum" do
      assert_difference('InventoryCheckDatum.count', -1) do
        delete :destroy, id: @inventory_check_datum
      end
  
      assert_redirected_to inventory_check_data_path
    end
  end
end
