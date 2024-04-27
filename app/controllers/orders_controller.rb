class OrdersController < ApplicationController

  def new
    @product = Product.find_by_id(params[:product_id])
    @order = current_admin_user.orders.build
  end

  def create
    product = Product.find_by_id(params[:product_id])
    # unless order_params[:payment_mode].eql?("cash_on_delivery")
    #   StripePaymentService.new(@product, current_admin_user).checkout
    # else
    # end
    @order = current_admin_user.orders.build(order_params.merge(status: order_params[:payment_mode].eql?("cash_on_delivery") ? "pending" : "paid", order_track_id: "TRA"+ "#{rand(1000000..9999999)}"))
    if @order.save
      redirect_to admin_orders_path, notice:"Order created!"
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :admin_user_id, :status, :payment_mode, :expected_delivery, :order_track_id, :address, :pin_code)
  end
end
