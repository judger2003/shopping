json.extract! cart, :id, :user_id, :product_id, :quantity, :created_at, :updated_at
json.url cart_url(cart, format: :json)
