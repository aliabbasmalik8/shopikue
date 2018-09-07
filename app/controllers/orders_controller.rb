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

  def add_to_cart
    check_order_exist=Order.where(user_id: current_user.id, status: 0).exists?
    if check_order_exist
      id_of_order=Order.where(user_id: current_user.id, status: 0).last.id
      OrderProduct.create!(order_id: id_of_order, product_id: params[:product_id])
      respond_to do |format|
        format.js {flash[:notice]= 'Add to cart Successfully.'}
      end
    else
      @order = current_user.orders.new
      @order.save
      OrderProduct.create(order_id: @order.id, product_id: params[:product_id])
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def order_params
    #   params.require(:order).permit!
    # end
end
