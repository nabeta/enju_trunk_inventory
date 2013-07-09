require 'test_helper'

module EnjuTrunkInventory
  class InventoryShelfBarcodeImportFilesControllerTest < ActionController::TestCase
    setup do
      @inventory_shelf_barcode_import_file = inventory_shelf_barcode_import_files(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:inventory_shelf_barcode_import_files)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create inventory_shelf_barcode_import_file" do
      assert_difference('InventoryShelfBarcodeImportFile.count') do
        post :create, inventory_shelf_barcode_import_file: { content_type: @inventory_shelf_barcode_import_file.content_type, edit_mode: @inventory_shelf_barcode_import_file.edit_mode, file_hash: @inventory_shelf_barcode_import_file.file_hash, import_file_name: @inventory_shelf_barcode_import_file.import_file_name, import_file_name: @inventory_shelf_barcode_import_file.import_file_name, import_file_size: @inventory_shelf_barcode_import_file.import_file_size, import_updated_at: @inventory_shelf_barcode_import_file.import_updated_at, imported_at: @inventory_shelf_barcode_import_file.imported_at, note: @inventory_shelf_barcode_import_file.note, size: @inventory_shelf_barcode_import_file.size, state: @inventory_shelf_barcode_import_file.state, user_id: @inventory_shelf_barcode_import_file.user_id }
      end
  
      assert_redirected_to inventory_shelf_barcode_import_file_path(assigns(:inventory_shelf_barcode_import_file))
    end
  
    test "should show inventory_shelf_barcode_import_file" do
      get :show, id: @inventory_shelf_barcode_import_file
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @inventory_shelf_barcode_import_file
      assert_response :success
    end
  
    test "should update inventory_shelf_barcode_import_file" do
      put :update, id: @inventory_shelf_barcode_import_file, inventory_shelf_barcode_import_file: { content_type: @inventory_shelf_barcode_import_file.content_type, edit_mode: @inventory_shelf_barcode_import_file.edit_mode, file_hash: @inventory_shelf_barcode_import_file.file_hash, import_file_name: @inventory_shelf_barcode_import_file.import_file_name, import_file_name: @inventory_shelf_barcode_import_file.import_file_name, import_file_size: @inventory_shelf_barcode_import_file.import_file_size, import_updated_at: @inventory_shelf_barcode_import_file.import_updated_at, imported_at: @inventory_shelf_barcode_import_file.imported_at, note: @inventory_shelf_barcode_import_file.note, size: @inventory_shelf_barcode_import_file.size, state: @inventory_shelf_barcode_import_file.state, user_id: @inventory_shelf_barcode_import_file.user_id }
      assert_redirected_to inventory_shelf_barcode_import_file_path(assigns(:inventory_shelf_barcode_import_file))
    end
  
    test "should destroy inventory_shelf_barcode_import_file" do
      assert_difference('InventoryShelfBarcodeImportFile.count', -1) do
        delete :destroy, id: @inventory_shelf_barcode_import_file
      end
  
      assert_redirected_to inventory_shelf_barcode_import_files_path
    end
  end
end
