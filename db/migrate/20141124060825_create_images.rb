class CreateImages < ActiveRecord::Migration
  def change
    create_table :shoppe_images do |t|
      t.attachment :file
      t.boolean :default, default: false, null: false
      t.integer :product_id
      t.integer :product_category_id
      t.timestamps
    end
  end
end
