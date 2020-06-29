class Customer < ApplicationRecord
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :validatable

	validates :first_name,presence:true
	validates :last_name,presence:true
	validates :first_name_kana,presence:true
	validates :last_name_kana,presence:true
	validates :postcode, format: {with: /\A[0-9]{3}[0-9]{4}\z/}
	validates :address,presence:true
	validates :phone_number,presence:true


	has_many :orders, dependent: :destroy
	has_many :shipping_addresses, dependent: :destroy
	has_many :cart_items, dependent: :destroy

	def active_for_authentication?
	    super && (self.is_deleted == false)
	end

	def name_all
		self.last_name + self.first_name
	end
end
