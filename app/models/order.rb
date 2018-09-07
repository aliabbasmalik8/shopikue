class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products, :dependent => :destroy
  has_many :products, through: :order_products

  enum status: [:draft, :confirm]

  scope :user_orders, -> (current_user){where(user_id: current_user.id)}
end
