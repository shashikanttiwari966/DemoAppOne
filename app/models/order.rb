class Order < ApplicationRecord
  enum status: [:pending, :paid, :delivered]
  enum payment_mode: [:cash_on_delivery, :online_payment]
  

  belongs_to :product
  belongs_to :admin_user

  has_many :shipments

end
