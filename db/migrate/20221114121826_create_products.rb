class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :sku
      t.string :name
      t.text :description
      t.decimal :weight
      t.integer :price
      t.integer :stock

      t.timestamps
    end
  end
end
