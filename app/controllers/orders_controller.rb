class OrdersController < ApplicationController
before_action :authorize_user

  def show
    @order = current_user.orders.where(paid: false )[0]
  end

  private

  def authorize_user
    redirect_to new_user_session_path if current_user == nil
  end
end
