class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /carts or /carts.json
  def index
    @carts = current_user.carts
  end

  # GET /carts/1 or /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts or /carts.json
  def create2
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
  def create
    @cart_item = Cart.find_by(user_id: current_user.id, product_id: params[:product_id])
    if @cart_item
      @cart_item.quantity += params[:quantity].to_i
      @cart_item.save
    else
      @cart_item = Cart.create(user_id: current_user.id, product_id: params[:product_id], quantity: params[:quantity])
    end
    render json: { success: true }
    # redirect_to cart_url(@cart), notice: "Cart was successfully updated."
  end
  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:user_id, :product_id, :quantity)
    end
end
