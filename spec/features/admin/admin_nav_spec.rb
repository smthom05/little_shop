require 'rails_helper'

RSpec.describe "As an admin", type: :feature do

  before :each do
    @admin = create(:user, role: 2)
    login_as(@admin)
  end

  it 'user sees appropriate nav bar links' do

    within ".general-nav" do
      expect(page).to have_link("Home")
      expect(page).to have_link("Browse Dishes")
      expect(page).to have_link("Restaurants")
    end

    within ".personal-nav" do
      expect(page).to have_link("Admin Dashboard")
      expect(page).to have_link("Users")
    end

    within ".auth-nav" do
      expect(page).to have_link("Log Out")
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Register")
    end

    within ".cart-nav" do
      expect(page).to_not have_link("Cart")
    end

    expect(page).to have_content("You have been logged in.")
  end

  it 'user can visit Home' do

    visit profile_path

    click_link "Home"

    expect(current_path).to eq(welcome_path)
  end

  it 'user can visit dashboard' do

    visit profile_path

    click_link "Admin Dashboard"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Administrator Information")
  end

  it 'user can visit users list' do

    visit profile_path

    click_link "Users"

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content("All Users")
  end

  it 'user can see dishes' do

    visit profile_path

    click_link "Browse Dishes"

    expect(current_path).to eq(items_path)
    expect(page).to have_content("All Items")

  end

  it 'user can see restaraunts' do

    visit profile_path

    click_link "Restaurants"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("All Merchants")
  end

  it "cannot see pages without permission" do

    visit profile_path
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit profile_edit_path
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit profile_orders_path
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit carts_path
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit cart_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
