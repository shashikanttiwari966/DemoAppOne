class Plan < ApplicationRecord
	enum duration: [:day, :week, :month, :year]
	has_one_attached :image

	after_create do
		plan = Stripe::Price.create(
				product_data:{
					name: self.name,
					type: "service",
				},
				currency: currency,
				unit_amount: set_price(self.price),
				recurring: {
					interval: 'month'
				}
			)

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
