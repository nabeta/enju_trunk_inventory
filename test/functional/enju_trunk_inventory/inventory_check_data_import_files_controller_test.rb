require 'test_helper'

module EnjuTrunkInventory
  class InventoryCheckDataImportFilesControllerTest < ActionController::TestCase
    setup do
      @inventory_check_data_import_file = inventory_check_data_import_files(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:inventory_check_data_import_files)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create inventory_check_data_import_file" do
      assert_difference('InventoryCheckDataImportFile.count') do
        post :create, inventory_check_data_import_file: { content_type: @inventory_check_data_import_file.content_type, file_hash: @inventory_check_data_import_file.file_hash, imported_at: @inventory_check_data_import_file.imported_at, note: @inventory_check_data_import_file.note, size: @inventory_check_data_import_file.size, state: @inventory_check_data_import_file.state, user_id: @inventory_check_data_import_file.user_id }
      end
  
      assert_redirected_to inventory_check_data_import_file_path(assigns(:inventory_check_data_import_file))
    end
  
    test "should show inventory_check_data_import_file" do
      get :show, id: @inventory_check_data_import_file
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @inventory_check_data_import_file
      assert_response :success
    end
  
    test "should update inventory_check_data_import_file" do
      put :update, id: @inventory_check_data_import_file, inventory_check_data_import_file: { content_type: @inventory_check_data_import_file.content_type, file_hash: @inventory_check_data_import_file.file_hash, imported_at: @inventory_check_data_import_file.imported_at, note: @inventory_check_data_import_file.note, size: @inventory_check_data_import_file.size, state: @inventory_check_data_import_file.state, user_id: @inventory_check_data_import_file.user_id }
      assert_redirected_to inventory_check_data_import_file_path(assigns(:inventory_check_data_import_file))
    end
  
    test "should destroy inventory_check_data_import_file" do
      assert_difference('InventoryCheckDataImportFile.count', -1) do
        delete :destroy, id: @inventory_check_data_import_file
      end
  
      assert_redirected_to inventory_check_data_import_files_path
    end
  end
end
