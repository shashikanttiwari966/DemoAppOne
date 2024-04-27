class Plan < ApplicationRecord
	enum duration: [:day, :week, :month, :year]
	has_one_attached :image

	# scope :created_at_gteq, ->  (data){
  #   self.where('id = ?', data)
  # }
  
  # scope :created_at_lteq_datetime, -> {
  #   self.where('created_at <= ?', Time.now.end_of_day)
  # }

  def self.ransackable_scopes(auth_object = nil)
    [:created_at_gteq_datetime]
  end

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
