class AddCustomerStripeIdToAdminUser < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :customer_stripe_id, :string
  end
end
