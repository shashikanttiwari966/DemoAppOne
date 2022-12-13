ActiveAdmin.register Charge do

  permit_params :stripe_charge_id, :product_id, :admin_user_id, :amount, :status

  index do
    selectable_column
    id_column
    column :admin_user
    column :product_id
    column :stripe_charge_id
    column :amount
    column :status
    actions do |charge|
      link_to "Refund", refund_payment_stripe_payments_path(id:charge.id), class:"subscribe"  unless current_admin_user.admin?
    end
  end

  controller do
    def index
      index! do |format|
        @charges = current_admin_user.admin? ? Charge.all : current_admin_user.charges
        @collection = @charges.page()
        format.html
      end
    end
  end
  
end
