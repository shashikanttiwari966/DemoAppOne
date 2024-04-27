class StripePaymentsController < ApplicationController

	def create
		@product = Product.find_by_id(params[:product_id])
    return redirect_to admin_products_path, alert:"Products are not available" if @product.stock.eql?(0)
    if current_admin_user.customer_stripe_id.present?
      begin
        session = Stripe::Checkout::Session.create({
          payment_method_types: ['card'],
          line_items: [{
            name: @product.name,
            amount: @product.price * 100,
            currency: "inr",
            # price: @product.price_id,
            quantity: params[:quantity].present? ? params[:quantity] : 1 ,
          }],
          mode: 'payment',
          customer: current_admin_user.customer_stripe_id,
          # client_reference_id: @product.product_id,
          success_url: success_stripe_payments_url(product_id: @product.id) + "&&session_id={CHECKOUT_SESSION_ID}",
          cancel_url: cancel_stripe_payments_url(product_id: @product.id),
        })

        return redirect_to session.url
      rescue Stripe::StripeError => e
        return redirect_to admin_products_path, alert:"#{e.message}"
      end
    else
      return redirect_to admin_products_path, alert:"You are not register in stripe."
    end
	end

  def refund_payment
    @charge = Charge.find_by_id(params[:id])
    if @charge.present? && (@charge.created_at + 10.minutes) >= Time.now.utc
      begin
        if @charge.stripe_charge_id.start_with?('ch')
         refund =  Stripe::Refund.create({charge: @charge.stripe_charge_id})
        else
          refund = Stripe::Refund.create({payment_intent: @charge.stripe_charge_id, amount: @charge.amount})
        end 
        @charge.update(status: "refunded")
        # Stripe::PaymentIntent.cancel(@charge.stripe_charge_id)
        return redirect_to admin_charges_path(),notice:"Amount refunded!"
      rescue Stripe::StripeError => e
        return redirect_to admin_charges_path(),alert:"#{e.message}"
      end
    end
    return redirect_to admin_charges_path(), alert:"You can't get refund because time limit has crosed!"
  end

  def subscription
    plan = Plan.find_by_id(params[:id])
    stripe_plan = Stripe::Plan.retrieve(plan.plan_id,) if plan.present?

    if check_subscription(stripe_plan).present?
      return redirect_to admin_plans_path, alert:"You have already subscribed of this plan."
    end
    
    if plan.plan_id.present? && current_admin_user.customer_stripe_id.present?
      begin
        session = Stripe::Checkout::Session.create({
          payment_method_types: ['card'],
          line_items: [{
            price: plan.plan_id,
            quantity: 1,
          }],
          mode: 'subscription',
          customer: current_admin_user.customer_stripe_id,
          client_reference_id: stripe_plan.product,
          success_url: success_stripe_payments_url(id: plan.id) + "&&session_id={CHECKOUT_SESSION_ID}",
          cancel_url: cancel_stripe_payments_url(charge_id: plan.id),
        })
        return redirect_to session.url
      rescue Stripe::StripeError => e
        return redirect_to admin_charges_path(),alert:"#{e.message}"
      end
    else
      return redirect_to admin_products_path, alert:"You are not register in stripe."
    end
  end

  def unsubscription
    subscription = current_admin_user.subscriptions.find_by_subscription_id(params[:id])
    if subscription&.subscription_id.present? && subscription.status == "complete"
      begin
        subs = Stripe::Subscription.update(subscription.subscription_id, { 
          cancel_at_period_end: true
        })

        subs = Stripe::Subscription.cancel(subscription.subscription_id)

        subscription.update(unsubscribed_at: Time.now, status: subs.status)
      rescue Stripe::StripeError => e
        return redirect_to admin_subscriptions_path(),alert:"#{e.message}"
      end
      return redirect_to admin_subscriptions_path, notice: "Unsubscription done!"
    else
      return redirect_to admin_subscriptions_path, alert: "Already Unsubscribed!"
    end

  end

	def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @product = Product.find_by_id(params[:product_id]) if params[:product_id].present?
    @plan = Plan.find_by_id(params[:id]) if params[:id].present?
    quantity = (@session.amount_total/100)/@product.price if params[:product_id].present?
    if subscription?
      create_notification(subscription?)
      created_at = Time.at(@session.created)
      current_admin_user.subscriptions.create(subscription_id: @session.subscription, product_id: @session.client_reference_id, status: @session.status, subscribed_at: created_at)
      redirect_to(admin_subscriptions_path, notice:"Subscription done!")
    else
      create_notification
      current_admin_user.charges.create(product_id: @product.id, amount: ((@session.amount_total)/100), status: @session.status, stripe_charge_id: @session.payment_intent)
      current_stock = @product.stock - quantity
      @product.update(stock: current_stock)
      @line_item = LineItem.find_by(product_id: @product.id)
      @line_item.destroy
      redirect_to admin_charges_path, notice:"Payment Successfull!"
    end
	end

	def cancel
		
	end

  private

  def create_notification(subscription = nil)
    UserNotification.with(
        message: "You have pay #{((@session.amount_total)/100)} for #{subscription.present? ? @plan.name : @product.name}", 
        params: [subscription.present? ? @plan: @product]
    ).deliver_later(current_admin_user)
  end

  def check_subscription(stripe_plan)
    current_admin_user.subscriptions.find_by(status:"complete", product_id: stripe_plan.product)
  end

  def subscription?
    @session.mode == "subscription"
  end
end
