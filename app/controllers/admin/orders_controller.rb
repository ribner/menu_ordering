module Admin
  class OrdersController < ApplicationController
    before_action :authorize_admin

    def index

        @orders = @shop.orders.where("order_status = ? or paid = ?", "submitted", false)
        @orders = @orders.order("order_status ASC, paid ASC")
      end
    end


    private

    def authorize_admin
      redirect_to new_user_session_path unless current_user.admin
    end

  end
end
