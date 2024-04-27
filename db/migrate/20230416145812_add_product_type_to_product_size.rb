class AddProductTypeToProductSize < ActiveRecord::Migration[6.1]
  def change
    add_column :product_sizes, :product_type, :string
  end
end
