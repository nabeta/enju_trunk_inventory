class AddColumnOriginalTitleAndNoteToInventoryCheckResults < ActiveRecord::Migration
  def change
    add_column :inventory_check_results, :original_title, :string
    add_column :inventory_check_results, :note, :text
  end
end
