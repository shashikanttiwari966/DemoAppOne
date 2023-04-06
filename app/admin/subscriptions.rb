ActiveAdmin.register Subscription do

  permit_params :admin_user_id, :subscription_id, :product_id, :subscribed_at, :unsubscribed_at, :status
  menu parent: 'Stripe Payment', priority: 4
  config.filters = false
  
  index do
    selectable_column
    id_column
    column "Buyer email" do |subs|
      subs.admin_user.email
    end
    column :subscribed_at
    column :unsubscribed_at
    column :status
    column :subscription_id
    column :product_id
    actions do |subs|
      link_to "Unsubscribe", unsubscription_stripe_payments_path(id:subs.subscription_id), method: :post, class:"unsubscription"  unless current_admin_user.admin?
    end
  end

  controller do
    def index
      index! do |format|
        @subscriptions = current_admin_user.admin? ? Subscription.all : current_admin_user.subscriptions
        @collection = @subscriptions.page()
        format.html
      end
    end
  end
end
