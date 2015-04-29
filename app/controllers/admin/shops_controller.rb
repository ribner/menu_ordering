module Admin
  class ShopsController < ApplicationController
    before_action :authorize_admin

    def show
      @shop = Shop.find(params[:id])
    end

    def edit
      @shop = Shop.find(params[:id])
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

    def authorize_admin
      redirect_to root_path unless current_user.admin
    end

  end
end




