class CartItem < ApplicationRecord
	validates :quantity, :numericality => { :greater_than => 0 }
	belongs_to :customer
	belongs_to :product

	def subtotal(price,quantity)
		quantity * (price * 1.10r).ceil
	end


end
