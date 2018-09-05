json.extract! product, :id, :title, :description, :price, :purchasing_price, :discount, :catagory, :rating, :created_at, :updated_at
json.url product_url(product, format: :json)
