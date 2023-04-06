class OrderProductsController < ApplicationController
  def index
    @product = Product.find_by_id(params[:product_id])
    if @product&.stock == 0
      return redirect_to admin_products_path, alert:"Currently products are not available."
    end
    @quantity = params[:quantity] if params[:quantity].present?
    @card_detail = CardDetail.new
    @amount = @product.price * 100 
  end

  def create
    @product = Product.find_by_id(params[:product_id])
    price = @product.price
    order = Razorpay::Order.create(amount: price, currency: 'INR', receipt: 'TEST', method: 'upi',)
    current_admin_user.order_products.create(product_id: @product.id, order_id: order.id, amount: @product.price)
    render json: order
  end

  def create_card
    @product = Product.find_by_id(params[:product_id])
    @card_detail = CardDetail.find_or_initialize_by(card_params)
    if @card_detail.save
      if @card_detail.card_token.present?
        begin
          charge_id = create_charge(@card_detail,@product)
          current_admin_user.charges.create(product_id: @product.id, amount: @product.price, status: "complete", stripe_charge_id: charge_id.id)
        rescue Stripe::StripeError => e
          return redirect_to admin_products_path(),notice:"#{e.message}"
        end
        return redirect_to admin_charges_path(), notice: "Payment Successfull Charge: #{charge_id.id}!!"
      end
    end
  end

  def success

  end

  def cancel
    
  end

  private

  def card_params
    params.require(:card_detail).permit(:email, :card_number, :expiry, :cvv)
  end

  def create_charge(card_detail,product)
    Stripe::Charge.create({
      amount: product.price * 100,
      currency: 'INR',
      source: card_detail.card_token
    })
  end
end
