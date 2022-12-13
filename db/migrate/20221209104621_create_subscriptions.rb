class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.string :subscription_id
      t.string :product_id
      t.datetime :subscribed_at
      t.datetime :unsubscribed_at
      t.string :status

      t.timestamps
    end
  end
end
