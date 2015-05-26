class OrderjoinsController < ApplicationController
  before_action :authorize_user

  def create
    @shop = Shop.find(params[:shop_id])
    @item_id = params[:item]
    @order = @shop.orders.where(paid: false, user_id: current_user)[0]
    if @order == nil
      flash[:notice] = "You must first record your table number"
      redirect_to shop_items_path(@shop)
    else
      @item = Item.find(params[:item_id])
      @orderjoin = @order.orderjoins.new(item_id: params[:item_id])
      @orderjoin.save
      flash[:notice] = "Item added to order"
      redirect_to shop_items_path(@shop)
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @orderjoin = Orderjoin.where("item_id = ? and order_id = ?", params[:item_id], params[:order_id])
    Orderjoin.delete(@orderjoin.first.id)
    redirect_to(:back)
  end

  private

  def authorize_user
    redirect_to new_user_session_path if current_user == nil
  end
end



