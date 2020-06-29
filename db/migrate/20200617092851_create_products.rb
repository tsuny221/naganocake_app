class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
    	t.string   :name
    	t.text     :description
    	t.integer   :category_id
    	t.integer   :price
    	t.string   :image_id
    	t.boolean   :sale_status


      t.timestamps
    end
  end
end
