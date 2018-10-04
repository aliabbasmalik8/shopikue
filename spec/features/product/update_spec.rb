require 'rails_helper'

RSpec.feature 'Product', type: :feature do
  given(:user) { create(:user, :user) }
  given(:moderator) { create(:user, :moderator) }
  given(:admin) { create(:user, :admin) }
  before do
    login_as admin
  end
  after do
    logout(admin)
  end
  scenario 'Update a product' do
    visit '/products/new'
    fill_in :product_title, with: 'Shirt'
    fill_in :product_description, with: 'this is good shirt'
    fill_in :product_price, with: 123
    fill_in :product_purchasing_price, with: 123
    fill_in :product_discount, with: 0
    fill_in :product_catagory, with: 'Shirt'
    find('input[name="commit"]').click

    visit '/products/1/edit'
    fill_in :product_title, with: 'Shirt'
    fill_in :product_description, with: 'this is good shirt'
    fill_in :product_price, with: 123
    fill_in :product_purchasing_price, with: 123
    fill_in :product_discount, with: 0
    fill_in :product_catagory, with: 'Shirt'
    find('input[name="commit"]').click

    expect(page).to have_text('Shirt')
  end
end
