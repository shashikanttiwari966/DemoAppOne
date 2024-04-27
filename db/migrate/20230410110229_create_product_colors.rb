class CreateProductColors < ActiveRecord::Migration[6.1]
  def change
    create_table :product_colors do |t|
      t.references :product, null: false, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
