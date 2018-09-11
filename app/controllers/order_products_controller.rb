class OrderProductsController < ApplicationController
  before_action :set_order_product, only: [:show]

  # GET /order_products
  # GET /order_products.json
  def index
    if current_user
      @order_products = OrderProduct.all
    else
      @order_products = []
      if !cookies[:add_to_cart].nil?
        JSON.parse(cookies[:add_to_cart]).each do |cookie|
          arr = []
          arr.push(Product.find(cookie["product_id"].to_i))
          arr.push(cookie["quantity"].to_i)
          @order_products << arr
        end
      end
    end
  end

  # GET /order_products/1
  # GET /order_products/1.json
  def show
  end

  # GET /order_products/new
  def new
    @order_product = OrderProduct.new
  end

  # GET /order_products/1/edit
  def edit
    if current_user
      @order_product = OrderProduct.find(params[:id])
    else

    end
  end

  # POST /order_products
  # POST /order_products.json
  def create
    @order_product = OrderProduct.new(order_product_params)

    respond_to do |format|
      if @order_product.save
        format.html { redirect_to @order_product, notice: 'Order product was successfully created.' }
        format.json { render :show, status: :created, location: @order_product }
      else
        format.html { render :new }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_products/1
  # PATCH/PUT /order_products/1.json
  def update
    if current_user
      @order_product = OrderProduct.find(params[:id])
      product=Product.find(@order_product.product_id)
      quantity=(params[:order_product][:quantity]).to_i
      total=(product.price)*quantity
      respond_to do |format|
        if @order_product.update(quantity: quantity, total: total)
          format.html { redirect_to @order_product, notice: 'Order product was successfully updated.' }
          format.json { render :show, status: :ok, location: @order_product }
        else
          format.html { render :edit }
          format.json { render json: @order_product.errors, status: :unprocessable_entity }
        end
      end
    else
      x = JSON.parse(cookies[:add_to_cart])
      x.delete_if { |h| h["product_id"] == params[:id] }
      x << {product_id: params[:id], quantity: params[:quantity]}
      cookies[:add_to_cart] = JSON.generate(x)
      respond_to do |format|
        format.html { redirect_to order_products_path, notice: 'Order product was successfully updated.' }
      end
    end
  end

  # DELETE /order_products/1
  # DELETE /order_products/1.json
  def destroy
    if current_user
      @order_product = OrderProduct.find(params[:id])
      @order_product.destroy
    else
      x = JSON.parse(cookies[:add_to_cart])
      x.delete_if { |h| h["product_id"] == params[:id] }
      cookies[:add_to_cart] = JSON.generate(x)
    end
    respond_to do |format|
      format.html { redirect_to order_products_url, notice: 'Order product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_product
      @order_product = OrderProduct.find(params[:id])
    end

    def order_product_params
      params.require(:order_product).permit(:quantity)
    end
end
