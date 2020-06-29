class AddColumnsToCustomers < ActiveRecord::Migration[5.2]
  def change
  	add_column :customers, :first_name, :string
  	add_column :customers, :last_name, :string
  	add_column :customers, :first_name_kana, :string
  	add_column :customers, :last_name_kana, :string
  	add_column :customers, :postcode, :string
  	add_column :customers, :address, :string
  	add_column :customers, :account_status, :boolean
  	add_column :customers, :phone_number, :string
  end
end
