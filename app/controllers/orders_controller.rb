class OrdersController < ApplicationController
	before_action :authenticate_customer!
	before_action :cart_item_nil, only:[:new, :confirm, :create]
	before_action :address_nil, only:[:new, :confirm]

	def new
		@order = Order.new
		@customer = current_customer
	end


	def confirm
		@order = Order.new
		@order.postage = 800
		@customer = current_customer

		if params[:pay_types] == "1"
			@order.pay_type = 1
		else
			@order.pay_type = 2
		end

		if params[:newaddress] == "1"
			@order.address = @customer.address
			@order.postcode = @customer.postcode
			@order.direction = @customer.last_name + @customer.first_name


		elsif params[:newaddress] == "2"
			@shipping_address = ShippingAddress.find(params[:order][:address2])
			#ShippingAddress.find_by(id: params[:order][:address2])でも可能。
			@order.address = @shipping_address.address
			@order.postcode = @shipping_address.postcode
			@order.direction = @shipping_address.direction

		elsif params[:newaddress] == "3"
			@order.address = params[:address3]
			@order.postcode = params[:postcode3]
			@order.direction = params[:direction3]
			@order.newaddress = 3
		end

	end

	def create
		@order = Order.new(order_params)
		@shipping_address = current_customer.shipping_addresses.new#
		#order_itemsのnew設定はここ,これでOrderのcreate時一緒に保存される
		@cart_items = CartItem.where(customer_id: current_customer.id)
		@cart_items.each do |cart_item|
			@order_item = @order.order_items.build
			@product = Product.find_by(id: cart_item.product_id)
			@order_item.product = @product
			@order_item.quantity = cart_item.quantity
			@order_item.tax_inclueded_price = @product.price_with_tax(@product.price)
		end
		@order.customer_id = current_customer.id
#confirmから３  条件分岐
if params[:order][:newaddress] == "3"
			@shipping_address.address = @order.address#
			@shipping_address.postcode = @order.postcode#
			@shipping_address.direction = @order.direction#
			@shipping_address.save

		end
		@order.save
			#binding.pry
			@cart_items.destroy_all
			redirect_to thanks_orders_path

		end



		def thanks
		end

		def show
			@order = Order.find(params[:id])
		end

		def index
			@orders = Order.where(customer_id: current_customer.id).page(params[:page]).reverse_order
		end


		private
		def order_params
			params.require(:order).permit(:address,:postcode,:direction,:buy_status,
				:pay_type,:postage,:total_price,:customer_id, [order_items_attribute: [:product_id, :quantity, :make_status, :tax_indlueded_price]])
		end
		def cart_item_nil
			@cart_items = current_customer.cart_items.all
			unless @cart_items.present?
				render 'cart_items/index'
			end
		end

		def address_nil
			@order = Order.new
			if (params[:address3].blank? || params[:postcode3].blank? || params[:direction3].blank?) && params[:newaddress] == "3"
	    	@customer = current_customer
	    	render :new
			end
		end

	end
