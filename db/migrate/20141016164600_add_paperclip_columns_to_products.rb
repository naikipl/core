class AddPaperclipColumnsToProducts < ActiveRecord::Migration
  def self.up
    add_attachment :shoppe_products, :data_sheet
  end

  def self.down
    remove_attachment :shoppe_products, :data_sheet
  end
end