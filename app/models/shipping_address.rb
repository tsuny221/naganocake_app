class ShippingAddress < ApplicationRecord

	belongs_to :customer

validates :address,:direction, presence: true
validates :postcode, format: {with: /\A[0-9]{3}[0-9]{4}\z/}
#{with: /\A[0-9]{3}-[0-9]{4}\z/}とかで真ん中にーも付けれる。


	def address_all
		self.direction + self.postcode + self.address
	end
end
