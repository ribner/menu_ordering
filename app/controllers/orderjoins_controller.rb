class OrderjoinsController < ApplicationController
before_action :authorize_user

  def create
    @shop = params[:shop_id]
    @item_id = params[:item]
    @order = current_user.orders.where(paid: false )[0]
    if @order == nil
      @order = current_user.orders.new
    end
    @orderjoin = @order.orderjoins.new(item_id: params[:item_id])
    if @orderjoin.save
      flash[:notice] = "Item added to order!"
      redirect_to shop_items_path(@shop)
    else
      flash[:errors] = @order.errors.full_messages
      redirect_to(:back)
    end
  end


  def show
    @order = Order.find(params[:id])
  end

  def edit
    
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


# and order_id: params[:order_id]