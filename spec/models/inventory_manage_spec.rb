# encoding: utf-8
require 'spec_helper'

describe InventoryManage do
  describe 'InventoryManageモデルは、' do
    it '空で保存するとエラーになること' do
      m = InventoryManage.new
      m.save.should_not be_true
      m.should have(1).error_on(:display_name)
    end
    it '資料区分と棚分類が未入力の場合はエラーになること' do
      m = InventoryManage.new
      m.display_name = "図書点検"
      m.save.should_not be_true
      m.should have(1).error_on(:base)
    end
  end
  describe '蔵書点検処理は、' do
    it '点検データが無い場合は例外を発行すること' do
      m = InventoryManage.find(1)
      proc { m.check }.should raise_error(EnjuTrunkInventoryCheckError, "ShelfBarcode is empry.")
    end
  end
end
