class AdminUser < ApplicationRecord
  role_based_authorizable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  has_many :notifications, as: :recipient, dependent: :destroy

  has_many :subscriptions
  has_many :charges
  has_many :order_products
  has_many :products, through: :order_products
  has_one :cart, dependent: :destroy
  has_one_attached :image

  has_many :rozarpay_subscriptions

  # after_update do
  #   begin
  #     UserMailer.with(user: self, password: self.password).welcome_email.deliver
  #   rescue StandardError => e
  #    puts e
  #   end
  # end

  after_create do
    customer = Razorpay::Customer.create({
      "email": self.email,
    }) || ""

    stripe_customer = Stripe::Customer.create({
      "email": self.email,
    }) || ""

    self.customer_stripe_id = stripe_customer.id
    self.customer_id = customer.id
    self.save
    begin
      UserMailer.with(user: self, password: self.password).welcome_email.deliver
    rescue StandardError => e
     puts e
    end
  end
end
