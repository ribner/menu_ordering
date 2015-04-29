class OrderjoinsController < ApplicationController
  before_action :authorize_user

  def create
    @shop = Shop.find(params[:shop_id])
    @item_id = params[:item]
    @order = @shop.orders.where(paid: false, user_id: current_user)[0]
    if @order == nil
      flash[:notice] = "You must first record your table number"
    else
      @orderjoin = @order.orderjoins.new(item_id: params[:item_id])
      if @orderjoin.save
        flash[:notice] = "Item added to order!"
      end
    end
    redirect_to shop_items_path(@shop)
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    #needs [0] at end of below statement ?
    @orderjoin = Orderjoin.where("item_id = ? and order_id = ?", params[:item_id], params[:order_id])
    Orderjoin.delete(@orderjoin.first.id)
    redirect_to(:back)
  end

  private

  def authorize_user
    redirect_to new_user_session_path if current_user == nil
  end
end



