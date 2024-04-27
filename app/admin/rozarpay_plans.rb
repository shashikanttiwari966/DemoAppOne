ActiveAdmin.register RozarpayPlan do

  permit_params :name, :description, :amount, :currency, :period, :plan_id
  menu false #parent: 'Rozarpay Payment', priority: 2

  filter :name

  index do |plan|
    # render partial: 'stripe_plans', locals:{context: self}
    selectable_column
    id_column
    column :name
    column :description
    column :amount
    column :currency
    column :period
    column :plan_id
    actions do |plan|
      link_to "Subscribe Now", rozarpay_payments_path(id:plan.id), method: :post, class:"subscribe"  unless current_admin_user.admin?
    end
  end
  
end
