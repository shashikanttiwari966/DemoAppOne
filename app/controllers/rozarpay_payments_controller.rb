class RozarpayPaymentsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:success]

	def create
		@plan = RozarpayPlan.find_by_id(params[:id])
		para_attr = {
			plan_id: @plan.plan_id,
			customer_notify: 1,
			total_count: 12,
			quantity: 1,
			# customer_id: current_admin_user.customer_id
			# addons: [
			# 	    {
			# 	  item: {
			# 	    name: "Delivery charges",
			# 	    amount: 30000,
			# 	    currency: "INR"
			# 	      }
			# 	    }
			# 	  ],
		}

		subscription = Razorpay::Subscription.create(para_attr)

		redirect_to subscription.short_url
	end

	def success
		current_admin_user.rozarpay_subscriptions.create(subscription_id:params["subscription_id"])
	end
end
