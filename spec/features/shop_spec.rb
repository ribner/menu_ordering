require 'rails_helper'

feature "user creates a restaurant", %Q{
  As an authenticated user
  I want to create a restaurant
  So that people can view my restaurant
} do

  let!(:shop) { FactoryGirl.create(:shop) }
  let!(:user) { FactoryGirl.create(:user) }
  before :each do
    sign_in user
  end



  scenario "user creates new restaurant" do
    visit root_path
    click_on "create restaurant"

    expect(page).to have_content("Name")
    expect(page).to have_content("Street address")
    expect(page).to have_content("City")
    expect(page).to have_content("State")
    expect(page).to have_content("Zip code")
    expect(page).to have_content("Description")
    expect(page).to have_content("Phone")
  end

  scenario "user provides valid information" do
    visit new_shop_path
    fill_in("Name", with: shop.name)
    fill_in("Street address", with: shop.street_address)
    fill_in("City", with: shop.city)
    select("Massachusetts", from: "State")
    fill_in("Zip code", with: shop.zip_code)
    fill_in("Description", with: shop.description)
    click_on("Create Shop")

    expect(page).to have_content("Restaurant created!")
  end

  scenario "user proivdes invalid information" do
    visit new_shop_path
    click_on("Create Shop")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Street address can't be blank")
    expect(page).to have_content("Zip code can't be blank")
  end

  scenario "user clicks shop link" do
    visit shops_path
    click_link shop.name, match: :first
    expect(page).to have_content(shop.name)
    expect(page).to have_content(shop.description)
    expect(page).to have_content("Phone")
    expect(page).to have_content(shop.phone)
    expect(page).to have_content("Reservations")
    expect(page).to have_content("Yes" || "No")
    expect(page).to have_content("Delivery")
    expect(page).to have_content("Yes" || "No")
  end
end








feature "user edits a shop they own", %Q{
  As a shop owner
  I want to edit my restaurant
  So others can see correct details
} do

  let!(:shop) { FactoryGirl.create(:shop) }
  let!(:user) { FactoryGirl.create(:user) }

  scenario "owner edits a shop they own" do
    sign_in shop.user
    visit shop_path(shop)
    page.should have_selector(:link_or_button, 'edit restaurant')
  end

  scenario "owner provides new valid information" do
    sign_in shop.user
    visit edit_shop_path(shop)
    fill_in("Description", with: "New description goes here")
    save_and_open_page
    click_button("Update Shop")
    expect(page).to have_content("Restaurant updated!")
  end

  scenario "owner provides new invalid information" do
    sign_in shop.user
    visit edit_shop_path(shop)

    fill_in("Name", with: "")
    click_button("Update Shop")
    expect(page).to have_content("Name can't be blank")
  end


  scenario "user attempts to update shop with invalid information" do
    sign_in shop.user
    visit edit_shop_path(shop)
    fill_in("Name", with: "")
    click_button("Update Shop")
    save_and_open_page
    expect(page).to have_content("Name can't be blank")
  end

  scenario "user tries to update a shop they don't own" do
    sign_in user
    visit shop_path(shop)
    expect(page).not_to have_content("edit restaurant")
  end
end

feature "user deletes a shop they own", %Q{
  As a shop owner
  I want to delete my shop
  Because it no longer exists
} do

  let!(:shop) { FactoryGirl.create(:shop) }

  scenario "owner visits their own shop's details page" do
    sign_in shop.user
    visit edit_shop_path(shop)

    page.should have_selector(:link_or_button, 'Delete')
  end

  scenario "owner deletes their own shop" do
    sign_in shop.user
    visit edit_shop_path(shop)
    click_link("Delete")

    expect(page).to have_content("Restaurant deleted!")
  end

end
