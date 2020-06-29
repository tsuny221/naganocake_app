class HomeController < ApplicationController
	def top
		@products = Product.page(params[:page]).reverse_order.per(6)
	end
end
