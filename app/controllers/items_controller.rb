class ItemsController < ApplicationController

  def new
    @item = Item.new
    @shop = Shop.find(params[:shop_id])
  end
  def create
    @shop = Shop.find(params[:shop_id])
    @item = @shop.items.new(item_params)
    if @item.save
      flash[:notice] = "Menu Item Created!"
      render :new
    else
      flash[:errors] = @item.errors.full_messages
      render :new
    end
  end
private

  def item_params
    params.require(:item).permit(
      :name, :category, :description, :price, :cost, :photo
      )
  end
end
