class RemoveShippingInfoFromOrders < ActiveRecord::Migration[7.0]
  remove_foreign_key :orders, :shipping_infos
  # 然后删除列
  remove_column :orders, :shipping_info_id
end
