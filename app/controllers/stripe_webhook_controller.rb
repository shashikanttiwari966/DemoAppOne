class StripeWebhookController < ApplicationController
	# skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

	def create
    payload = request.body.read
    sig_header = ENV['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
          payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      status 400
      return
    end

    # Handle the event
    case event.type
    when 'charge.failed'
        charge = event.data.object
    when 'charge.pending'
        charge = event.data.object
    when 'charge.refunded'
        charge = event.data.object
    when 'charge.succeeded'
        charge = event.data.object
    when 'checkout.session.async_payment_succeeded'
        session = event.data.object
    when 'checkout.session.completed'
        session = event.data.object
    when 'checkout.session.expired'
        session = event.data.object
    when 'subscription_schedule.canceled'
        subscription_schedule = event.data.object
    when 'subscription_schedule.completed'
        subscription_schedule = event.data.object
    when 'subscription_schedule.created'
        subscription_schedule = event.data.object
    # ... handle other event types
    else
        puts "Unhandled event type: #{event.type}"
    end

    status 200
	end
end
