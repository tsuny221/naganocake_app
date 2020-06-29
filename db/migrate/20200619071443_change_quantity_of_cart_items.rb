class ChangeQuantityOfCartItems < ActiveRecord::Migration[5.2]
  def up
    change_column :cart_items, :quantity, :integer, default: 1
  end

  def down
    change_column :cart_items, :quantity, :integer
  end
end
