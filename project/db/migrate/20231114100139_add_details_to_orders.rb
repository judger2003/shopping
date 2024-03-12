class AddDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :receiver, :string
    add_column :orders, :address, :string
    add_column :orders, :phone_number, :string
    add_column :orders, :postal_code, :string
  end
end
