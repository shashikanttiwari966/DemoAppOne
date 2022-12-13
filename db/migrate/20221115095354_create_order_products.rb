class CreateOrderProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :order_products do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :order_id
      t.integer :amount

      t.timestamps
    end
  end
end
