class Product < ApplicationRecord
  has_many :favorites,dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_many :carts,dependent: :destroy
  has_many :carted_by, through: :carts, source: :user
  has_many :order_products
  has_many :getorders ,through: :order_products,source: :order
end
