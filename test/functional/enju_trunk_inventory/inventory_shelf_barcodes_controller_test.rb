require 'test_helper'

module EnjuTrunkInventory
  class InventoryShelfBarcodesControllerTest < ActionController::TestCase
    setup do
      @inventory_shelf_barcode = inventory_shelf_barcodes(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:inventory_shelf_barcodes)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create inventory_shelf_barcode" do
      assert_difference('InventoryShelfBarcode.count') do
        post :create, inventory_shelf_barcode: { barcode: @inventory_shelf_barcode.barcode }
      end
  
      assert_redirected_to inventory_shelf_barcode_path(assigns(:inventory_shelf_barcode))
    end
  
    test "should show inventory_shelf_barcode" do
      get :show, id: @inventory_shelf_barcode
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @inventory_shelf_barcode
      assert_response :success
    end
  
    test "should update inventory_shelf_barcode" do
      put :update, id: @inventory_shelf_barcode, inventory_shelf_barcode: { barcode: @inventory_shelf_barcode.barcode }
      assert_redirected_to inventory_shelf_barcode_path(assigns(:inventory_shelf_barcode))
    end
  
    test "should destroy inventory_shelf_barcode" do
      assert_difference('InventoryShelfBarcode.count', -1) do
        delete :destroy, id: @inventory_shelf_barcode
      end
  
      assert_redirected_to inventory_shelf_barcodes_path
    end
  end
end
