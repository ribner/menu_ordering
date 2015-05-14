require 'rails_helper'

feature "user places order", %Q{
  As an authenticated user
  I want to order items
  so that I can eat
} do

  let!(:shop) { FactoryGirl.create(:shop) }
  let!(:item) { FactoryGirl.create(:item) }
  let!(:user) { FactoryGirl.create(:user) }
  before :each do
    sign_in user
  end

  scenario "user successfully creates order" do
    visit shop_path(item.shop)
    fill_in "Table number", with: "1"
    click_button("Menu")
    expect(page).to have_content("New Party Created")
    click_button("order item")
    expect(page).to have_content("on it's way!")
  end

  scenario "user orders menu item without first inputting table" do
    visit shop_items_path(item.shop)
    click_button("order item")
    expect(page).to have_content("You must first record your table number")
  end
end

