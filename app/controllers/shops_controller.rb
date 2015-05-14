class ShopsController < ApplicationController
  before_action :authorize_user

  def new
    @shop = current_user.shops.new
  end

  def create
    @shop = current_user.shops.new(shop_params)
    if @shop.save
      current_user.define_admin
      flash[:notice] = "Restaurant created!"
      redirect_to @shop
    else
      flash[:errors] = @shop.errors.full_messages
      render :new
    end
  end

  def show
    @order = Order.new
    @shop = Shop.find(params[:id])
  end

  def index
    @shops = Shop.all
  end

  private

  def shop_params
    params.require(:shop).permit(
      :name, :street_address, :city, :state, :zip_code, :description,
      :phone, :reservations, :delivery, :category_id, :user_id, :photo
      )
  end

  def authorize_user
    redirect_to new_user_session_path if current_user == nil
  end

end
