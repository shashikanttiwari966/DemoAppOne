class Product < ApplicationRecord
	has_many_attached :images
	has_many :order_products
	has_many :admin_users, through: :order_products
	belongs_to :category
	has_many :product_colors, :inverse_of => :product
	has_many :product_sizings

	has_many :orders, dependent: :destroy

	validates :product_type, presence: true

	accepts_nested_attributes_for :product_colors, allow_destroy: true
	accepts_nested_attributes_for :product_sizings, allow_destroy: true

	PRODUCT_TYPE = [
		"Cloths",
		"Electronics",
		"Grocery", 
		"Shoes"	
	]
end
