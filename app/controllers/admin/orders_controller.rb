module Admin
  class OrdersController < ApplicationController
    before_action :authorize_admin
    before_action :find_shop, only: [:index]
    def index
      @orders = @shop.orders.where("order_status = ? or paid = ?", "submitted", false)
      @orders = @orders.order("order_status ASC, paid ASC")
    end




    private

    def find_shop
      @shop = Shop.find(params[:shop_id])
    end

    def authorize_admin
      redirect_to new_user_session_path unless current_user.admin
    end

  end
end
