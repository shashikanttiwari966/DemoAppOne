class Charge < ApplicationRecord
	belongs_to :admin_user
	enum status: [:complete, :refunded]
end
