class CreateShippingInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_infos do |t|
      t.string :receiver
      t.string :address
      t.string :phone_number
      t.string :postal_code

      t.timestamps
    end
  end
end
