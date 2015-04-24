module Admin
  class BarchartsController < ApplicationController
    before_action :authorize_admin

    def index
      @shop = Shop.find(params[:shop_id])
      @item_array = []
      @shop_order_item_ids = []
      @orders = @shop.orders
      @items = @shop.items
      @items.each { |item| @item_array << item.name }
      @items.each { |item| @shop_order_item_ids << item.id }
      @shop_order_item_ids.each do |id|
        result = Orderjoin.where(item_id: id)
        #must sort results by
      end
    end

    private

    def authorize_admin
      redirect_to new_user_session_path unless current_user.admin
    end

  end
end
