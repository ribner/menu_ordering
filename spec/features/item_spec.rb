require 'rails_helper'

feature "user creates item", %Q{
  As an authenticated user
  I want to add menu item
  so that people can view my offerings
} do

  let!(:shop) { FactoryGirl.create(:shop) }
  let!(:item) { FactoryGirl.create(:item) }
  # let!(:user) { FactoryGirl.create(:user) }
  before :each do
    user1 = item.shop.user
    user1.admin = true
    sign_in user1
    user1.save
  end

  scenario "user successfully creates new menu item" do
    visit new_admin_shop_item_path(shop)
    fill_in "Name", with: "burger"
    fill_in "Description", with: "very nice burger"
    fill_in "Price", with: "5"
    click_button("add / edit menu item")
    expect(page).to have_content("very nice burger")
  end

  scenario "user submits menu item without contents" do
    visit new_admin_shop_item_path(shop)
    click_button("add / edit menu item")
    expect(page).to have_content("Price can't be blank")
    expect(page).to have_content("Name can't be blank")
  end
end

feature "user deletes menu item", %Q{
  As an authenticated user
  I want to create a review
  so that people can view my recommendation
} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:item) { FactoryGirl.create(:item) }

  scenario "user successfully deletes menu item" do
    user1 = item.shop.user
    user1.admin = true
    sign_in user1
    user1.save
    visit edit_admin_shop_item_path(item.shop, item)
    click_link("Delete Item")
    expect(page).to have_content("Item Deleted!")
  end

  scenario "user cannot edit other user's menu items" do
    sign_in user
    visit edit_admin_shop_item_path(item.shop, item)
    expect(page).to have_content("Introducing the most advanced and user friendly ordering system")
  end
end



