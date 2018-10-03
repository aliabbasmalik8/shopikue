require 'rails_helper'

RSpec.feature "Product", :type => :feature do
  scenario "Create a new product" do
    visit "/products/new"

    fill_in "product[title]", :with => "Shirt"
    fill_in "description", :with => "this is good shirt"
    fill_in "price", :with => 123
    fill_in "purchasing_price", :with =>123
    fill_in "discount", :with =>0
    fill_in "catagory", :with => "Shirt"

    click_button "product"

    expect(page).to have_text("Shirt")
  end
end