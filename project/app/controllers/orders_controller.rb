class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /orders or /orders.json
  def index
    puts "Request format: #{request.format}"
    puts "Parameters: #{params.inspect}"
    if current_user.has_role? :god
     @orders = if params[:status]
                            Order.where(status: params[:status])
                          else
                            Order.all
                          end
    else
      @orders = if params[:status]
                  current_user.orders.where(status: params[:status])
                else
                  current_user.orders.all
                end
    end
    respond_to do |format|
      format.html
      format.js
    end
    end
  def pass
    @order = Order.find(params[:id])
    respond_to do |format|
    if @order.update(status:"sending")
      format.html { redirect_to orders_path, notice: "Order was successfully updated." }
      format.json { render :show, status: :ok, location: @order }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @order.errors, status: :unprocessable_entity }
    end
    end
  end
  def receive
    @order = Order.find(params[:id])
    respond_to do |format|
    if @order.update(status:"finished")
      format.html { redirect_to orders_path, notice: "Order was successfully updated." }
      format.json { render :show, status: :ok, location: @order }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @order.errors, status: :unprocessable_entity }
    end
    end
  end
  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    total = 0
    @order = Order.new
    @products = Product.find(session[:product_ids].split(","))
    @shipping_info = ShippingInfo.find(session[:selected_shipping_info])
    @order.receiver = @shipping_info.receiver
    @order.address = @shipping_info.address
    @order.phone_number = @shipping_info.phone_number
    @order.postal_code = @shipping_info.postal_code
    @order.user = current_user
    @order.status = "waiting pass"
    @products.each do |product|
      num = Cart.where(user: current_user, product: product).first.quantity
      price = product.price
      total = total +price*num
      @order.order_products.new(product:product,quantity:
        num)
    end
    @order.total = total
    respond_to do |format|
      if @order.save
        @products.each do |product|
          num = Cart.where(user: current_user, product: product).first.quantity
          sales = product.sales+num
          while(true)
            if product.update(sales:sales)
              break
            else
              sleep(1)
            end
          end
          current_user.cart_products.destroy(product)
        end
        format.html { redirect_to products_read_path, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :shipping_info_id, :status, :total,:product_ids)
    end
end
