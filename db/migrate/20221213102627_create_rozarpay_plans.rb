class CreateRozarpayPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :rozarpay_plans do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.string :currency
      t.integer :period
      t.string :plan_id

      t.timestamps
    end
  end
end
