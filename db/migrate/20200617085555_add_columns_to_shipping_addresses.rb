class AddColumnsToShippingAddresses < ActiveRecord::Migration[5.2]
def change
	add_column :shipping_addresses, :customer_id, :integer
	add_column :shipping_addresses, :address, :string
	add_column :shipping_addresses, :postcode, :string
	add_column :shipping_addresses, :direction, :string
end
end
