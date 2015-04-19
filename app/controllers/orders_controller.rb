class OrdersController < ApplicationController
before_action :authorize_user

  def show
    @order = current_user.orders.where(paid: false )[0]
    @shop = params[:shop_id]
  end
  
  def edit
  	@order = Order.find(params[:id])
  	if params[:paid]
  		@order.paid = true
  	end
  	binding.pry
  	redirect_to(:back)
  end

  private

  def authorize_user
    redirect_to new_user_session_path if current_user == nil
  end
end
