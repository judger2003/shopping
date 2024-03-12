class ShippingInfo < ApplicationRecord
  #has_many :orders
  belongs_to :user
end
