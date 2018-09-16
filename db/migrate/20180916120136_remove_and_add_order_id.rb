class RemoveAndAddOrderId < ActiveRecord::Migration[5.2]
  def change
    remove_column :payment_notifications, :order_id
    add_column :payment_notifications, :order_id, :string
  end
end
