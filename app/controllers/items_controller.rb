class ItemsController < ApplicationController

  def index
    @shop = Shop.find(params[:shop_id])
    @items = @shop.items
  end
  def new
    @item = Item.new
    @shop = Shop.find(params[:shop_id])
  end
  def create
    @shop = Shop.find(params[:shop_id])
    @item = @shop.items.new(item_params)
    if @item.save
      flash[:notice] = "Menu Item Created!"
      redirect_to shop_items_path(@shop)
    else
      flash[:errors] = @item.errors.full_messages
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    @shop = @item.shop
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "Menu item updated!"
      redirect_to shop_items_path(@item.shop)
    else
      flash[:errors] = @shop.errors.full_messages
      render :edit
    end
  end
private

  def item_params
    params.require(:item).permit(
      :name, :category, :description, :price, :cost, :photo
      )
  end
end
