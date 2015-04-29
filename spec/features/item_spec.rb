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
    sign_in shop.user
  end

  scenario "user successfully creates new menu item" do
    visit new_admin_shop_item_path(shop)
    save_and_open_page
    fill_in "Name", with: "burger"
    fill_in "Description", with: "very nice burger"
    fill_in "Price", with: "5"
    click_button("add menu item")
    expect(page).to have_content("very nice burger")

  end

  scenario "user submits menu item without contents" do
    visit new_admin_shop_item_path(shop)
    click_button("add menu item")
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

    visit edit_admin_shop_item_path(item.shop, item)
    click_link("Delete Item")
    expect(page).to have_content("Item Deleted!")
  end

  scenario "user cannot delete other user's menu items" do
    sign_in user
    visit edit_admin_shop_item_path(item.shop, item)
    click_link("Delete Item")
    expect(page).to have_content("Cannot edit others users' menu")
  end
end

feature "guest can't add a menu item", %Q{
  As a guest
  I should not be able to add a menu item
  Because I am not signed in
} do

  let!(:shop) { FactoryGirl.create(:shop) }

  scenario "guest tries to edit menu" do
    visit admin_shop_items_path(shop)
    expect(page).not_to have_content("Introducing the most advanced and user friendly ordering system")
  end
end

feature "user edits item", %Q{
  As an authenticated user
  I want to edit a menu item I wrote
  so that I can change the associated information
} do
  let!(:shop) { FactoryGirl.create(:shop) }
  let!(:item) { FactoryGirl.create(:item) }
  let!(:user) { FactoryGirl.create(:user) }
  before :each do
    user1 = item.shop.user
    user1.admin = true
    sign_in user1
  end

  scenario "user tries to edit a menu item" do

    visit edit_admin_shop_item_path(item.shop, item)
    save_and_open_page
    expect(page).to have_content("Delete Item")
  end


end
