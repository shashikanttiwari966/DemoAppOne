class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.string :stripe_charge_id
      t.integer :product_id
      t.integer :admin_user_id
      t.integer :amount
      t.integer :status

      t.timestamps
    end
  end
end
