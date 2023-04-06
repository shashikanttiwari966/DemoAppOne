class CreateRozarpaySubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :rozarpay_subscriptions do |t|
      t.string :plan_id
      t.string :subscription_id
      t.datetime :start_at
      t.datetime :unsubscribe_at
      t.string :status
      t.integer :amount
      t.references :admin_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
