json.extract! product, :id, :name, :description, :price, :sales, :created_at, :updated_at
json.url product_url(product, format: :json)
