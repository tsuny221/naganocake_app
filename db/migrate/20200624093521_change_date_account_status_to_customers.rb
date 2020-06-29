class ChangeDateAccountStatusToCustomers < ActiveRecord::Migration[5.2]
  def change
  	change_column :customers, :account_status, :boolean, default:"有効"
  end
end
