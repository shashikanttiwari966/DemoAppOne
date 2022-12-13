class Product < ApplicationRecord
	has_many_attached :images
	has_many :order_products
	has_many :admin_users, through: :order_products
end
