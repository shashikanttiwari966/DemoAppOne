ActiveAdmin.register Plan do

  permit_params :name, :plan_id, :duration, :price, :description

  filter :name

  index do |plan|
    # render partial: 'stripe_plans', locals:{context: self}
    selectable_column
    id_column
    column :name
    column :plan_id
    column :duration
    column :price
    column :description
    actions do |plan|
      link_to "Subscribe Now", subscription_stripe_payments_path(id:plan.id), method: :post, class:"subscribe"  unless current_admin_user.admin?
    end
  end
  
end
