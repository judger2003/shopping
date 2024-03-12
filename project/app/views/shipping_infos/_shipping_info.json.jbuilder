json.extract! shipping_info, :id, :receiver, :address, :phone_number, :postal_code, :created_at, :updated_at
json.url shipping_info_url(shipping_info, format: :json)
