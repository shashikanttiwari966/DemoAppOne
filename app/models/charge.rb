class Charge < ApplicationRecord
	belongs_to :admin_user
	enum status: {complete: 0, refunded: 1}
end
