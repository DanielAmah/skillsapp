class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :token
      t.string :transaction_id
      t.string :address_one
      t.string :address_two
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :status
      t.string :number
      t.string :uuid
      t.string :user_id
      t.string :price
      t.decimal :shipping
      t.string :tracking_number
      t.string :phone
      t.string :name
      t.date :expiration
      t.timestamps
    end
  end
end
