class RozarpayPlan < ApplicationRecord
	enum period: [:daily, :weekly, :monthly, :yearly]

	after_create do
		para_attr = {
		  period: self.period,
		  interval: 1,
		  item: {
		    name: self.name,
		    amount: self.amount,
		    currency: "INR",
		    description: self.description
		  },
		}
		plan = Razorpay::Plan.create(para_attr)

		self.plan_id = plan.id
		self.save
	end

	def currency
    "inr"
  end

  def set_price(price)
  	price * 100
  end
end
