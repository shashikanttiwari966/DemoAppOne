class ProductSizing < ApplicationRecord
  belongs_to :product
  validates :product_size_id, presence: true
end
