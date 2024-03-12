class Order < ApplicationRecord
  belongs_to :user
  #belongs_to :shipping_info
  #belongs_to :user
  #belongs_to :shipping_info
  has_many :order_products,dependent: :destroy
  has_many :products,through: :order_products,source: :products
end
