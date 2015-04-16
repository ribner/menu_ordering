require 'rails_helper'

feature "user creates item", %Q{
  As an authenticated user
  I want to add menu item
  so that people can view my offerings
} do

  let!(:shop) { FactoryGirl.create(:shop) }
  let!(:item) { FactoryGirl.create(:item) }
  let!(:user) { FactoryGirl.create(:user) }
  before :each do
    sign_in user
  end

  scenario "user successfully creates new menu item" do
    visit new_shop_item_path(shop)
    fill_in "Name", with: "burger"
    fill_in "Description", with: "very nice burger"
    fill_in "Price", with: "5"
    click_button("Create Item")
    click_link("view menu")
    expect(page).to have_content("very nice burger")

  end

  scenario "user submits menu item without contents" do
    visit new_shop_item_path(shop)
    click_button("Create Item")
    expect(page).to have_content("Price can't be blank")
    expect(page).to have_content("Name can't be blank")
  end
end

# feature "user deletes menu item", %Q{
#   As an authenticated user
#   I want to create a review
#   so that people can view my recommendation
# } do

#   let!(:user) { FactoryGirl.create(:user) }
#   let!(:shop) { FactoryGirl.create(:shop) }

#   scenario "user successfully deletes menu item" do
#     sign_in shop.user
#     visit shop_path(shop)
#     click_link("Delete")
#     expect(page).to have_content("Item Deleted!")
#   end

#   scenario "user cannot delete other user's menu items" do
#     sign_in user
#     visit shop_path(shop)
#     expect(page).to have_content(item.description)
#     expect(page).not_to have_content("Delete Item")
#   end
# end

feature "guest can't add a menu item", %Q{
  As a guest
  I should not be able to review a restaurant
  Because I am not signed in
} do

  let!(:shop) { FactoryGirl.create(:shop) }

  scenario "guest tries to review a restaurant" do
    visit shop_path(shop)
    save_and_open_page
    expect(page).not_to have_content("Create Item")
  end
end

feature "user edits item", %Q{
  As an authenticated user
  I want to edit a menu item I wrote
  so that I can change the associated information
} do

  let!(:item) { FactoryGirl.create(:item) }
  before :each do
    sign_in item.shop.user
  end

  scenario "user tries to edit a menu item" do
    sign_in item.shop.user
    visit shop_path(item.shop)
    click_link("#{item.shop.name}")
    save_and_open_page
    expect(page).to have_content("Edit Menu Item")
  end

  scenario "user tries to edit a review he/she has written" do
    visit edit_restaurant_review_path(review.restaurant, review)
    fill_in "Body", with: "I changed my mind, and this place sucks"
    click_button("Update Review")

    expect(page).to have_content("Review updated!")
  end

  scenario "user submits edited review without body" do
    visit edit_restaurant_review_path(review.restaurant, review)
    fill_in "Body", with: ""
    click_button("Update Review")

    expect(page).to have_content("Body can't be blank")
  end
end
