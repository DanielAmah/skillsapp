class AddCompletedAndPaymentTime < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :completed, :boolean, :default => false
    add_column :orders, :time_of_payment, :datetime
  end
end
