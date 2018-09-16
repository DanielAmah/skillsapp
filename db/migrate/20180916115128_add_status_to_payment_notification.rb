class AddStatusToPaymentNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_notifications, :status, :string

  end
end
