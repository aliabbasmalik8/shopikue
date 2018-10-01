class Payment
  def self.total_amount(user_id)
    order_id = Order.where(user_id: user_id, status: 0).ids
    @amount = OrderProduct.where(order_id: order_id).sum(:total).to_i
  end
  def self.update_order_status(user_id, amount)
    order_id = Order.where(user_id: user_id, status: 0).ids
    order = Order.find(order_id)
    order[0].update(status: 1, total: amount)
  end
  def self.widgets_count(user_id)
    order_id = Order.where(user_id: user_id, status: 0).ids
    @widgets_count = OrderProduct.where(order_id: order_id).count  
  end
end
