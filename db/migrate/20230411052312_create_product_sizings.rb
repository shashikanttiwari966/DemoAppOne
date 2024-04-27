class CreateProductSizings < ActiveRecord::Migration[6.1]
  def change
    create_table :product_sizings do |t|
      t.references :product, null: false, foreign_key: true
      t.references :product_size, null: false, foreign_key: true

      t.timestamps
    end
  end
end
