json.extract! order, :id, :user_id, :shipping_info_id, :status, :total, :created_at, :updated_at
json.url order_url(order, format: :json)
