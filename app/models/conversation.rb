class Conversation < ApplicationRecord
  # belongs_to :user
  has_many :messages, dependent: :destroy
  belongs_to :admin_user
end
