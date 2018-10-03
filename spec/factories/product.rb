# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title               { Faker::Book.title }
    description         { Faker::Book.title }
    price               { Faker::Number.number(3) }
    purchasing_price    { Faker::Number.number(3) } 
    discount            { 0 }
    catagory            { 'Product' }
    rating              { 1 }
  end
end
