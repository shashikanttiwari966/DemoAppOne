ActiveAdmin.register RozarpaySubscription do

  permit_params :plan_id, :subscription_id, :start_at, :unsubscribe_at, :status, :amount, :admin_user_id
  menu parent: 'Rozarpay Payment', priority: 3
  config.filters = false
  
  index do
    selectable_column
    id_column
    column "Buyer email" do |subs|
      subs.admin_user.email
    end
    column :plan_id
    column :unsubscribed_at
    column :start_at
    column :subscription_id
    column :status
    column :amount
    actions do |subs|
      link_to "Unsubscribe", unsubscription_rozarpay_payments_path(id:subs.subscription_id), method: :post, class:"unsubscription"  unless current_admin_user.admin?
    end
  end

  controller do
    def index
      index! do |format|
        @subscriptions = current_admin_user.admin? ? RozarpaySubscription.all : current_admin_user.rozarpay_subscriptions
        @collection = @subscriptions.page()
        format.html
      end
    end
  end
  
end
