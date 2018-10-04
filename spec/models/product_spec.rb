# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }

  it 'has a valid factory' do
    expect(product).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:purchasing_price) }
  it { is_expected.to validate_presence_of(:discount) }
  it { is_expected.to validate_presence_of(:catagory) }
end
