ActiveAdmin.register Plan do
  permit_params :name, :plan_id, :duration, :price, :description, :image
  menu parent: 'Stripe Payment', priority: 1
  filter :name

  index do |plan|
    # render partial: 'stripe_plans', locals:{context: self}
    # if current_admin_user.admin?
      selectable_column
      id_column
      column :name
      column :plan_id
      column :duration
      column :price
      column :description
      column "image" do |plan_image|
        if plan_image.image.attached?
          image_tag(plan_image.image, class:"plan_image")
        end
      end
      actions do |plan|
        link_to "Subscribe Now", subscription_stripe_payments_path(id:plan.id), method: :post, class:"subscribe"  unless current_admin_user.admin?
      end
    # else
    #   panel "Plan Lists" do
    #     render :partial => "index"
    #   end
    # end
  end

  form do |f|
    f.inputs do
      input :name
      input :plan_id
      input :duration
      input :description
      input :price
      input :image, as: :file
    end
    f.actions
  end
  
end
