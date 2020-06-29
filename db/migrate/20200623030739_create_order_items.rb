class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
    	t.integer  :quantity
    	t.integer  :tax_inclueded_price
    	t.integer  :make_status
    	t.integer  :order_id
    	t.integer  :product_id
      t.timestamps
    end
  end
end
