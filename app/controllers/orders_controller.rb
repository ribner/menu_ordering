class OrdersController < ApplicationController
before_action :authorize_user
before_action :find_shop, only: [:index, :create]

  def show
    @order = current_user.orders.where(paid: false)[0]
    unless @order
      @order = current_user.orders.where(paid: true).last
    end
    @shop = params[:shop_id]
  end

  def edit
    @order = Order.find(params[:id])
  	if params[:paid]
  		@order.paid = true
      @order.save
  	elsif params[:order_status] == "fulfilled"
      @order.order_status = "fulfilled"
      @order.save
      flash[:notice] = "Order Status Changed"
    end
  	redirect_to(:back)
  end

  def index
    @orders = @shop.orders.where("order_status = ? or paid = ?", "submitted", false)
    @orders = @orders.order("order_status ASC, paid ASC")
  end

  def destroy
    @orderjoins = Orderjoin.where(order_id: params[:id])
    Orderjoin.delete(@orderjoins)
    flash[:notice] = "Order Cleared"
    redirect_to(:back)
  end

  def create
    @table_number = params[:order][:table_number]
    @order = @shop.orders.where("paid = ? and table_number = ?", false, @table)[0]
    if @order == nil
      @order = current_user.orders.new(shop_id: params[:shop_id], table_number: @table_number)
      @order.save
      flash[:notice] = "New Party Created"
    end
    redirect_to shop_items_path(@shop)
  end

  private
  def find_shop
      @shop = Shop.find(params[:shop_id])
  end

  def authorize_user
    redirect_to new_user_session_path if current_user == nil
  end
end
