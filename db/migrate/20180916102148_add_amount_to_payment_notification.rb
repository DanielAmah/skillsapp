class AddAmountToPaymentNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_notifications, :amount, :string
    change_column :payment_notifications, :order_id, :string
  end
end
