class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def self.order_exist(user_id)
    Order.where(user_id: user_id, status: 0).count >= 1
  end
end
