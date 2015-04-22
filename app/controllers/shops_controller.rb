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
    @shop = Shop.find(params[:id])
    @google_maps_url = %Q{
      https://www.google.com/maps/embed/v1/place?key=
      #{ENV["GOOGLE_MAPS_API_KEY"]}&q=#{@shop.parse_for_google_maps}
    }
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def index
      @shops = Shop.all
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:notice] = "Restaurant updated!"
      redirect_to @shop
    else
      flash[:errors] = @shop.errors.full_messages
      render :edit
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    flash[:notice] = "Restaurant deleted!"
    redirect_to root_path
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
