class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.user_orders(current_user)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_products = @order.order_products.includes(:product)
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.new
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_to_cookie(product_id,quantity)
    a=[]
    if cookies[:add_to_cart].nil?
      a << {product_id: product_id, quantity: quantity}
      cookies[:add_to_cart] = JSON.generate(a)
    else
      x = JSON.parse(cookies[:add_to_cart])
      if x.any? {|h| h["product_id"]==product_id }
        x.each do |elem|
          if elem["product_id"]==product_id
            quantity=quantity.to_i+(elem["quantity"]).to_i
          end
        end
        x.delete_if { |h| h["product_id"] == product_id }
      end
      x << {product_id: product_id, quantity: quantity}
      cookies[:add_to_cart] = JSON.generate(x)
    end
  end

  def add_cart
    @product=Product.includes(:images, :comments).where(id: params[:product_id]).first
  end

  def add_to_cart
    if !current_user
      add_to_cookie(params[:product_id],params[:quantity])
    else
      Order.add_to_cart(params[:product_id],params[:quantity],current_user)
    end
    respond_to do |format|
      format.html {redirect_to order_products_url, notice: 'Add to cart Successfully.'}
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
end