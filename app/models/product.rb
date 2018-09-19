class Product < ApplicationRecord
    has_many :images, as: :imageable
    has_many :comments
    has_many :order_products
    has_many :orders, through: :order_products
    has_many :ratings, as: :rateable

    def first_image
        if images.any?
            images.first.image
        else
            'default_product.png'
        end
    end
end
