class AddColumnsToCategories < ActiveRecord::Migration[5.2]
  def change
  	add_column :categories, :name, :string
  	add_column :categories, :active_status, :boolean, default: "有効"
  end
end
