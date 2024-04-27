class StripePaymentService < ApplicationService
  attr_accessor :product, :user

  def initialize(product, user, quantity = nil)
    @product = product
    @user = user
  end

  def checkout
    begin
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          name: @product.name,
          amount: @product.price * 100,
          currency: "inr",
          quantity: quantity.present? ? quantity : 1 ,
        }],
        mode: 'payment',
        customer: user.customer_stripe_id,
        # client_reference_id: @product.product_id,
        success_url: success_stripe_payments_url(product_id: @product.id) + "&&session_id={CHECKOUT_SESSION_ID}&&request_type='order'",
        cancel_url: cancel_stripe_payments_url(product_id: @product.id),
      })

      return redirect_to session.url
    rescue Stripe::StripeError => e
      return redirect_to admin_products_path, alert:"#{e.message}"
    end
  end
end