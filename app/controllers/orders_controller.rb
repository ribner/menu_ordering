class OrdersController < ApplicationController
  before_action :authorize_user
  before_action :find_shop, only: [:index, :create, :show]

  def show
    @order = @shop.orders.where(paid: false, user_id: current_user)[0]
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
    end
    redirect_to(:back)
  end

  def create
    @table_number = params[:order][:table_number]
    if @table_number == ""
      flash[:notice] = "must enter table number"
      redirect_to shop_path(@shop)
    else
      @order = @shop.orders.where(paid: false, user_id: current_user)[0]
      if @order == nil
        @order = current_user.orders.new(shop_id: params[:shop_id], table_number: @table_number)
        @order.save
        flash[:notice] = "New Party Created"
      else
        flash[:notice] = "Order Already Open"
      end
      redirect_to shop_items_path(@shop)
    end
  end

  private

  def find_shop
    @shop = Shop.find(params[:shop_id])
  end

  def authorize_user
    redirect_to new_user_session_path if current_user == nil
  end
end
