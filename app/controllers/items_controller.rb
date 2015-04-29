class ItemsController < ApplicationController
  before_action :authorize_user
  before_action :find_item, only: [:edit, :update, :destroy]
  before_action :find_shop, only: [:index, :new, :create]

  def import
    Item.import(params[:file],params[:shop_id])
    redirect_to root_url, notice: "Products imported."
  end

  def index
    @item = Item.new
    @items = @shop.items
    @order = Order.new
  end

  def new
    @item = Item.new
  end

  private

  def find_shop
    @shop = Shop.find(params[:shop_id])
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name, :category, :description, :price, :cost, :photo
      )
  end

  def authorize_user
    redirect_to new_user_session_path if current_user == nil
  end
end
