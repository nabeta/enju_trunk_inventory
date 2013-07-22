require 'spec_helper'

describe InventoryManagesController do
  fixtures :all

  it "should be a kind of enju_trunk_inventory" do
    assert_kind_of Module, EnjuTrunkInventory
  end
end
