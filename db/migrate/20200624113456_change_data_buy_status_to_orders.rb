class ChangeDataBuyStatusToOrders < ActiveRecord::Migration[5.2]
  def change
  	change_column :orders, :buy_status, :integer, default: 0
  end
end
