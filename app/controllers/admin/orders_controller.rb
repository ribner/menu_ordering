module Admin
  class OrdersController < ApplicationController
    before_action :authorize_admin
    before_action :find_shop, only: [:index]
    def index
      if params[:all]
        get_all_orders(@shop)
      elsif params[:today]
        get_todays_orders(@shop)
      else
        get_open_orders(@shop)
      end
    end

    def destroy
      @orderjoins = Orderjoin.where(order_id: params[:id])
      Orderjoin.delete(@orderjoins)
      flash[:notice] = "Order Cleared"
      redirect_to(:back)
    end

    def edit
      @order = Order.find(params[:id])
      if params[:order_status] == "fulfilled"
        @order.order_status = "fulfilled"
        @order.save
        flash[:notice] = "Order fulfilled"
      end
      redirect_to(:back)
    end


    private

    def find_shop
      @shop = Shop.find(params[:shop_id])
    end

    def authorize_admin
      redirect_to new_user_session_path unless current_user.admin
    end

    def get_todays_orders(shop)
      @orders = shop.orders.where("created_at > ?", Time.now-1.days)
    end

    def get_all_orders(shop)
      @orders = @shop.orders.all
    end

    def get_open_orders(shop)
      @unsorted_orders = shop.orders.where("order_status = ? or paid = ?", "submitted", false)
      @orders = @unsorted_orders.order("order_status ASC, paid ASC")
  end

  end
end
