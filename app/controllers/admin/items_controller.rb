module Admin
  class ItemsController < ApplicationController
    before_action :authorize_admin

    def new
      @shop = Shop.find(params[:shop_id])
      @item = Item.new
    end

    def index
      @shop = Shop.find(params[:shop_id])
      @items = @shop.items
    end

    def edit
      @item = Item.find(params[:id])
      @shop = @item.shop
    end

    def update
      @item = Item.find(params[:id])
      if @item.update(item_params)
        flash[:notice] = "Menu item updated!"
        redirect_to admin_shop_items_path(@item.shop)
      else
        flash[:errors] = @shop.errors.full_messages
        render :edit
      end
    end

    def create
      @shop = Shop.find(params[:shop_id])
      @item = @shop.items.new(item_params)
      if @item.save
        flash[:notice] = "Menu Item Created!"
        redirect_to admin_shop_items_path(@shop)
      else
        flash[:errors] = @item.errors.full_messages
        render :new
      end
    end


    def destroy
      @item = Item.find(params[:id])
      if @item.shop.user == current_user
        @item.destroy
        flash[:notice] = "Menu Item Deleted!"
      else
        flash[:erros] = "Cannot edit others users' menu"
      end
      redirect_to shop_path(@item.shop)
    end

    private

    def item_params
      params.require(:item).permit(
        :name, :category, :description, :price, :cost, :photo
        )
    end

    def authorize_admin
      redirect_to root_path unless current_user.admin
    end

  end
end
