# encoding: utf-8
class AddInitrecordsToInventoryShelfGroups < ActiveRecord::Migration
  def change
    InventoryShelfGroup.create!(:name=>'S1', :display_name=>'図書')
    InventoryShelfGroup.create!(:name=>'S2', :display_name=>'雑誌')
    InventoryShelfGroup.create!(:name=>'S3', :display_name=>'資料')
    InventoryShelfGroup.create!(:name=>'S4', :display_name=>'短期')
    InventoryShelfGroup.create!(:name=>'S5', :display_name=>'予備')
  end
end
