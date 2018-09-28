class Product < ApplicationRecord
    has_many :images, as: :imageable, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :order_products, dependent: :destroy
    has_many :orders, through: :order_products
    has_many :ratings, as: :rateable, dependent: :destroy, validate: false
    acts_as_paranoid

    validates :title, :description, :price, :purchasing_price, :discount, :catagory , presence: true
    validates :price, :purchasing_price, :discount, format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }

    def first_image
        if images.any?
            images.first.image
        else
            'default_product.png'
        end
    end
end
