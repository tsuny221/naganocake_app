class CartItemsController < ApplicationController
before_action :authenticate_customer!
	def index
		@cart_items = CartItem.where(customer_id: current_customer.id)
	end

	def create
		@cart_item = current_customer.cart_items.build(cart_item_params)
		@cart_items = current_customer.cart_items.all

	unless @cart_item.quantity.present?
		@product = Product.find(@cart_item.product_id)
		render "products/show"
	else			#byebug
		@cart_items.each do |cart_item|
			if cart_item.product_id == @cart_item.product_id
			add_quantity = cart_item.quantity + @cart_item.quantity
			cart_item.update_attribute(:quantity, add_quantity)
			@cart_item.delete
			end
		end#each文のend
			@cart_item.save
			flash[:notice] = "カートに商品を追加しました"
			redirect_to :cart_items
		end
	end

	def update
		@cart_item = CartItem.find(params[:id])
		if @cart_item.update(cart_item_params)
			flash[:notice] = "カートの中身をを更新しました"
			redirect_to cart_items_path
		else
			render :index
		end
	end

	def destroy
		@cart_items = CartItem.find(params[:id])
		@cart_items.destroy
		redirect_to cart_items_path
	end

	def destroy_all
		@cart_items = CartItem.where(customer_id: current_customer.id)
		@cart_items.destroy_all
		redirect_to cart_items_path
	end



	private
	def cart_item_params
		params.require(:cart_item).permit(:product_id, :quantity)
	end

end
