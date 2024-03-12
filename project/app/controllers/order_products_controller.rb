class OrderProductsController < ApplicationController
  before_action :set_order_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /order_products or /order_products.json
  def index
    if params[:product_ids]
    product_ids = params[:product_ids].split(',')
    session[:product_ids] = product_ids
    else
    product_ids = session[:product_ids]
    end# 将字符串分割成数组
    @products = Product.find(product_ids)
    @order = Order.new
    @selected_shipping_info = ShippingInfo.find(session[:selected_shipping_info]) if session[:selected_shipping_info]
  end
  def choose
    @shipping_infos = current_user.shipping_infos
  end
  def update_address
    session[:selected_shipping_info] = params[:shipping_info]
    redirect_to order_products_path
  end
  # GET /order_products/1 or /order_products/1.json
  def show
  end

  # GET /order_products/new
  def new
    @order_product = OrderProduct.new
  end

  # GET /order_products/1/edit
  def edit
  end

  # POST /order_products or /order_products.json
  def create
    @order_product = OrderProduct.new(order_product_params)

    respond_to do |format|
      if @order_product.save
        format.html { redirect_to order_product_url(@order_product), notice: "Order product was successfully created." }
        format.json { render :show, status: :created, location: @order_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_products/1 or /order_products/1.json
  def update
    respond_to do |format|
      if @order_product.update(order_product_params)
        format.html { redirect_to order_product_url(@order_product), notice: "Order product was successfully updated." }
        format.json { render :show, status: :ok, location: @order_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_products/1 or /order_products/1.json
  def destroy
    @order_product.destroy

    respond_to do |format|
      format.html { redirect_to order_products_url, notice: "Order product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_product
      @order_product = OrderProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_product_params
      params.require(:order_product).permit(:order_id, :product_id, :quantity)
    end
end
