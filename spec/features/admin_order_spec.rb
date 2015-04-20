require 'rails helper'

feature 'admin views their orders', %{
	As an admin user
	I want to view my orders
	so that i can fufill them
}

  scenario "Admin can view all the open orders of their restaurant"
    shop = FactoryGirl.create(:shop)
    item = FactoryGirl.create(:item)
    order = FactoryGirl.create(:order)

    sign_in shop.user
    visit admin_shop_order_path(shop)


  end


scenario "Admin can change order status to closed for any order in restaurant"
scenario "Admin can delete any order from restaurants page"
end
