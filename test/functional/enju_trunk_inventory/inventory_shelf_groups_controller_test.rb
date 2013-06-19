require 'test_helper'

module EnjuTrunkInventory
  class InventoryShelfGroupsControllerTest < ActionController::TestCase
    setup do
      @inventory_shelf_group = inventory_shelf_groups(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:inventory_shelf_groups)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create inventory_shelf_group" do
      assert_difference('InventoryShelfGroup.count') do
        post :create, inventory_shelf_group: { display_name: @inventory_shelf_group.display_name, name: @inventory_shelf_group.name }
      end
  
      assert_redirected_to inventory_shelf_group_path(assigns(:inventory_shelf_group))
    end
  
    test "should show inventory_shelf_group" do
      get :show, id: @inventory_shelf_group
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @inventory_shelf_group
      assert_response :success
    end
  
    test "should update inventory_shelf_group" do
      put :update, id: @inventory_shelf_group, inventory_shelf_group: { display_name: @inventory_shelf_group.display_name, name: @inventory_shelf_group.name }
      assert_redirected_to inventory_shelf_group_path(assigns(:inventory_shelf_group))
    end
  
    test "should destroy inventory_shelf_group" do
      assert_difference('InventoryShelfGroup.count', -1) do
        delete :destroy, id: @inventory_shelf_group
      end
  
      assert_redirected_to inventory_shelf_groups_path
    end
  end
end
