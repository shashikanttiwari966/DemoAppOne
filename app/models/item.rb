class Item < ApplicationRecord
	after_create do
		item = Razorpay::Item.create({
		  name: self.name,
		  description: self&.description,
		  amount: self.amount,
		  currency:"INR"
		});

		self.item_id = item.id
		self.save
	end
end
