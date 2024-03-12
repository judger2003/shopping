class ShippingInfosController < ApplicationController
  before_action :set_shipping_info, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /shipping_infos or /shipping_infos.json
  def index
    @shipping_infos = current_user.shipping_infos
  end
  def new_index
    @shipping_info = ShippingInfo.new
  end
  def create_index
    @shipping_info = current_user.shipping_infos.new(shipping_info_params)
    respond_to do |format|
      if @shipping_info.save
        format.html { redirect_to shipping_infos_path, notice: "Shipping info was successfully created." }
        format.json { render :show, status: :created, location: @shipping_info }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shipping_info.errors, status: :unprocessable_entity }
      end
    end
  end
  # GET /shipping_infos/1 or /shipping_infos/1.json
  def show
  end

  # GET /shipping_infos/new
  def new
    @shipping_info = ShippingInfo.new
  end
  # GET /shipping_infos/1/edit
  def edit
  end
  # POST /shipping_infos or /shipping_infos.json
  def create
    @shipping_info = current_user.shipping_infos.new(shipping_info_params)
    respond_to do |format|
      if @shipping_info.save
        format.html { redirect_to choose_order_products_path, notice: "Shipping info was successfully created." }
        format.json { render :show, status: :created, location: @shipping_info }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shipping_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipping_infos/1 or /shipping_infos/1.json
  def update
    respond_to do |format|
      if @shipping_info.update(shipping_info_params)
        format.html { redirect_to shipping_info_url(@shipping_info), notice: "Shipping info was successfully updated." }
        format.json { render :show, status: :ok, location: @shipping_info }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shipping_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_infos/1 or /shipping_infos/1.json
  def destroy
    @shipping_info.destroy

    respond_to do |format|
      format.html { redirect_to shipping_infos_url, notice: "Shipping info was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping_info
      @shipping_info = ShippingInfo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shipping_info_params
      params.require(:shipping_info).permit(:receiver, :address, :phone_number, :postal_code,:user_id)
    end
end
