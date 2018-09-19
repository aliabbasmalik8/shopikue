class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products, :dependent => :destroy
  has_many :products, through: :order_products

  enum status: [:draft, :confirm]

  scope :user_orders, -> (current_user){where(user_id: current_user.id)}


  def self.add_to_cart(product_id,quantity,current_user)

    product=Product.find(product_id)
    check_order_exist=Order.where(user_id: current_user.id, status: 0).exists?

    if check_order_exist
      id_of_order=Order.where(user_id: current_user.id, status: 0).last.id

      #check weather same product exist in user add to cart lisgt
      check_order_product_exist=OrderProduct.where(order_id: id_of_order, product_id: product_id).exists?

      if check_order_product_exist
        op=OrderProduct.where(order_id: id_of_order, product_id: product_id)

        latest_quantity = (op[0].quantity) + quantity.to_i

        total=product.price*latest_quantity

        op.update(quantity: latest_quantity, total: total)

        update_order_total(id_of_order)
      else

        total=product.price*quantity.to_i
        OrderProduct.create!(order_id: id_of_order, product_id: product_id,quantity: quantity, total: total)

      end

    else
      @order = current_user.orders.new
      @order.save
      total=product.price*quantity.to_i
      OrderProduct.create(order_id: @order.id, product_id: product_id, quantity: quantity, total: total)
    end
  end

  def self.update_order_total(order_id)
    total=OrderProduct.where(order_id: order_id).pluck(:total).inject(0, :+)
    order=Order.find(order_id)
    order.update!(total: total)
  end

end