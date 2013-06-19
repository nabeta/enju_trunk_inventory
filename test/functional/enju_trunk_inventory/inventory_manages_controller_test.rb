require 'test_helper'

module EnjuTrunkInventory
  class InventoryManagesControllerTest < ActionController::TestCase
    setup do
      @inventory_manage = inventory_manages(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:inventory_manages)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create inventory_manage" do
      assert_difference('InventoryManage.count') do
        post :create, inventory_manage: { display_name: @inventory_manage.display_name, manifestation_type_ids: @inventory_manage.manifestation_type_ids, notification_dest: @inventory_manage.notification_dest, shelves_group_ids: @inventory_manage.shelves_group_ids, state: @inventory_manage.state }
      end
  
      assert_redirected_to inventory_manage_path(assigns(:inventory_manage))
    end
  
    test "should show inventory_manage" do
      get :show, id: @inventory_manage
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @inventory_manage
      assert_response :success
    end
  
    test "should update inventory_manage" do
      put :update, id: @inventory_manage, inventory_manage: { display_name: @inventory_manage.display_name, manifestation_type_ids: @inventory_manage.manifestation_type_ids, notification_dest: @inventory_manage.notification_dest, shelves_group_ids: @inventory_manage.shelves_group_ids, state: @inventory_manage.state }
      assert_redirected_to inventory_manage_path(assigns(:inventory_manage))
    end
  
    test "should destroy inventory_manage" do
      assert_difference('InventoryManage.count', -1) do
        delete :destroy, id: @inventory_manage
      end
  
      assert_redirected_to inventory_manages_path
    end
  end
end
