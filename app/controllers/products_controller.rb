class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # after_action :verify_authorized, except: :index

  # GET /products
  # GET /products.json
  def index
    @products = Product.without_deleted.includes(:images).paginate(page: params[:product_page], per_page: 4)
    @paid_orders = Order.where(status: 1).paginate(page: params[:paid_order_order], per_page: 4)
    @fulfilled_orders = Order.where(status: 2).paginate(page: params[:fulfilled_orde_page], per_page: 4)
    @users = User.all.paginate(page: params[:user_page], per_page: 4)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @imageable = @product
    @images = @imageable.images
    @image = Image.new
  end

  # GET /products/new
  def new
    @product = Product.new
    authorize @product
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    authorize @product
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:title, :description, :price, :purchasing_price, :discount, :catagory, :rating)
  end
end
