class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :plan_id
      t.integer :duration
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
