ActiveAdmin.register Charge do

  permit_params :stripe_charge_id, :product_id, :admin_user_id, :amount, :status
  menu parent: 'Stripe Payment', priority: 2, label: "<i class='fas fa-rupee-sign'></i>Charge".html_safe

  collection_action :update_charge, method: :put
  index do
    selectable_column
    id_column
    column :admin_user
    column :product_id
    column :stripe_charge_id
    column :amount
    # column 'Amount' do |charge|
    #   best_in_place charge, :amount, as: :input, url: admin_charge_url(charge)
    # end
    # column 'Status' do |charge|
    #   best_in_place charge, :status, as: :select, :collection => Charge.statuses.map{|m,n| [n,"#{m}"]}, url: admin_charge_url(charge)
    # end
    tag_column :status
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

      def update
        super
      end
    end
  end
  
end
