class ProductsController < ApplicationController

	def index
		@products = Product.page(params[:page]).reverse_order.per(9)
	end

	def show
		@product = Product.find(params[:id])
		@cart_item = CartItem.new
	end

	 private
	def product_params
		params.require(:product).permit(:name,:description,:price,:image,:category_id,:sale_status)
	end
end
