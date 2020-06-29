class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
    	t.string   :address
    	t.string   :postcode
    	t.string   :direction
    	t.integer  :buy_status
    	t.integer  :pay_type
    	t.integer  :postage
    	t.integer  :total_price
    	t.integer  :customer_id
      t.timestamps
    end
  end
end
