# encoding: utf-8
require 'spec_helper'

describe InventoryManage do
 describe 'InventoryManageモデルは、' do
   it '空で保存するとエラーになること' do
      m = InventoryManage.new
      m.save.should_not be_true
    end
  end

end
