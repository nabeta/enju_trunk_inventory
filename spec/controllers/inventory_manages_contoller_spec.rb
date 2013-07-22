require 'spec_helper'

describe InventoryManagesController do
  fixtures :all

  it "should be a kind of enju_trunk_inventory" do
    assert_kind_of Module, EnjuTrunkInventory
  end

  describe "GET index" do
    login_fixture_admin

    #it "should be empty if a query is not set", :vcr => true do
    it "should be empty" do
      get :index
      assigns(:books).should be_empty
    end
  end

end
