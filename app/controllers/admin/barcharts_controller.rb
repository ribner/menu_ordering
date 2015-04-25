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
      # @items.each { |item| @item_array << item.name }
      # @items.each { |item| @shop_order_item_ids << item.id }
      @items.each do |item|
        @item_array << item.name
        @item_order_count = Orderjoin.where(item_id: item.id).count
        @item_revenue = @item_order_count * item.price
        @total_item_revenue << @item_revenue
      end
    end

    private

    def authorize_admin
      redirect_to new_user_session_path unless current_user.admin
    end

  end
end



# def index
#       @shop = Shop.find(params[:shop_id])
#       @item_array = []
#       @shop_order_list = []
#       @shop_order_item_ids = []
#       @orders = @shop.orders
#       @items = @shop.items
#       @items.each { |item| @item_array << item.name }
#       @items.each { |item| @shop_order_item_ids << item.id }
#       @shop_order_item_ids.each do |id|
#         @item_order_count = Orderjoin.where(item_id: id).count
#         #must sort results by
#       end
#       binding.pry
#     end
