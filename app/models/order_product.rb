class OrderProduct < ApplicationRecord
  belongs_to :admin_user
  belongs_to :product
end
