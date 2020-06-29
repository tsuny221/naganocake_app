class ChangeDataSaleStatusToProducts < ActiveRecord::Migration[5.2]
  def change
  	change_column :products, :sale_status, :boolean, default: "販売中"
  end
end
