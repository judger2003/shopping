class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_format_of :email,:with => Devise::email_regexp
  has_many :favorites,dependent: :destroy
  has_many :favorite_products, through: :favorites, source: :product
  has_many :carts,dependent: :destroy
  has_many :cart_products, through: :carts, source: :product
  has_many :orders,dependent: :destroy
  has_many :shipping_infos,dependent: :destroy
  # 验证密码长度和复杂性
  validates_length_of :password, minimum: 8, allow_blank: true
  validates_format_of :password,
                      with: /\A(?=.*[a-zA-Z])(?=.*\d)/x,
                      message: "must include at least one letter and one digit"
  after_create :assign_default_role
  def assign_default_role
    self.add_role(:normal) if self.roles.blank?
  end
end
