class Product < ApplicationRecord
    has_many :images, as: :imageable
    has_many :comments
    has_many :order_products
    has_many :orders, through: :order_products
end
