# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) { create(:product) }
  let(:user) { create(:user, :user) }
  let(:moderator) { create(:user, :moderator) }
  let(:admin) { create(:user, :admin) }

  describe 'POST #create' do
    context 'with user credentials' do
      before do
        sign_in user
      end
      after do
        sign_out user
      end
      it 'create new product with valid attributes' do
        before_count = Product.count
        post :create, params: { product: attributes_for(:product) }
        expect(Product.count).to eq(before_count)
      end
      it 'create new product with invalid attributes' do
        before_count = Product.count
        post :create, params: { product: attributes_for(:product, price: 'test') }
        expect(Product.count).to eq(before_count)
      end
    end
  
    context 'with moderator credentials' do
      before do
        sign_in moderator
      end
      after do
        sign_out moderator
      end
      it 'create new product with valid attributes' do
        before_count = Product.count
        post :create, params: { product: attributes_for(:product) }
        expect(Product.count).to eq(before_count)
      end
      it 'create new product with invalid attributes' do
        before_count = Product.count
        post :create, params: { product: attributes_for(:product, price: 'test') }
        expect(Product.count).to eq(before_count)
      end
    end
  
    context 'with admin credentials' do
      before do
        sign_in admin
      end
      after do
        sign_out admin
      end
      it 'create new product with valid attributes' do
        before_count = Product.count
        post :create, params: { product: attributes_for(:product) }
        expect(Product.count).to eq(before_count + 1)
      end
      it 'create new product with invalid attributes' do
        before_count = Product.count
        post :create, params: { product: attributes_for(:product, price: 'test') }
        expect(Product.count).to eq(before_count)
      end
    end
  end

end
