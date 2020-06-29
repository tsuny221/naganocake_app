class Product < ApplicationRecord
	belongs_to :category
	attachment :image, destroy: false
	has_many :cart_items, dependent: :destroy
	has_many :order_items, dependent: :destroy


validates :name, presence: true
validates :price, numericality: { only_integer: true }
#数字だけ許可。数字以外、空白を許可しない

	#税込価格表示
	def price_with_tax(price)
		(price * 1.10r).ceil
	end
end
