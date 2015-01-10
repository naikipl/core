class CreateImages < ActiveRecord::Migration
  def change
    create_table :shoppe_images do |t|
      t.attachment :source
      t.boolean :default, default: false, null: false
      t.integer :product_id
      t.integer :product_category_id
      t.integer :height
      t.integer :width
      t.timestamps
    end
  end
end
