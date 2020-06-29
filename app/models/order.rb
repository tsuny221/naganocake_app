class Order < ApplicationRecord
	validates :pay_type,:address,:direction, presence: true
	validates :postcode, format: {with: /\A[0-9]{3}[0-9]{4}\z/}
	attr_accessor :newaddress,:pay_types,:postcode3,:address3,:direction3,:address2
	belongs_to :customer
	has_many :order_items,  dependent: :destroy
	accepts_nested_attributes_for :order_items, allow_destroy: true

	enum pay_type: { クレジットカード: 1, 銀行振り込み: 2 }
	enum buy_status:[:入金待ち, :入金確認, :製作中, :発送準備中, :発送済]
#勝手に0,1,2,3と数字が振り分けられる。
end
