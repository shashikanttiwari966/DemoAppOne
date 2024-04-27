class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :product, null: false, foreign_key: true
      t.references :admin_user, null: false, foreign_key: true
      t.integer :status
      t.integer :payment_mode
      t.datetime :expected_delivery
      t.string :order_track_id
      t.text :address
      t.integer :pin_code

      t.timestamps
    end
  end
end
