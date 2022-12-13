class CardDetail < ApplicationRecord

	after_initialize :create_card

	def create_card
		if self.card_number.present?
			exp = expiry.split('/')
			exp_month = exp[0]
			exp_year = exp[1]
			token = Stripe::Token.create({
	      card: {
	        number: card_number,
	        exp_month: exp_month,
	        exp_year: exp_year,
	        cvc: cvv,
	      },
	    })

	    if token.present?
	    	self.update(card_token: token.id)
	    end
	  end
	end
end
