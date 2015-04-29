module Admin
  class BarchartsController < ApplicationController
    before_action :authorize_admin

    def index
      @shop = Shop.find(params[:shop_id])
      @item_array = []
      @total_item_revenue = []
      @shop_order_list = []
      @shop_order_item_ids = []
      @orders = @shop.orders
      @items = @shop.items
      @items.each do |item|
        @item_array << item.name
        @item_order_count = Orderjoin.where(item_id: item.id).count
        @item_revenue = @item_order_count * item.price
        @total_item_revenue << @item_revenue
      end
    end

    private

    def authorize_admin
      redirect_to root_path unless current_user.admin
    end

  end
end


