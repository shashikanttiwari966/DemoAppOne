class Shipment < ApplicationRecord
  belongs_to :order
  enum status: [:ordered, :shipment, :out_for_delivery, :arriving]
end
