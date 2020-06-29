class Admins::OrdersController < ApplicationController
before_action :authenticate_admin!

	def index
		@orders = Order.page(params[:page]).reverse_order
	end

	def show
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		@order_items = OrderItem.where(order_id: @order.id)
		if params[:order][:buy_status] == "入金確認"
			@order_items.update_all(make_status: "製作待ち")
		elsif params[:order][:buy_status] == "発送済"
			@order_items.update_all(make_status: "発送済")
		end
		if @order.update(order_params)
		flash[:notice] = "購入ステータスを更新しました"
		redirect_to admins_orders_path
		else
		render :show
		end
	end

	def destroy
		@order = Order.find(params[:id])
		@order.destroy
		redirect_to admins_orders_path, notice: "注文をキャンセルしました"
	end

	private
		def order_params
			params.require(:order).permit(:address,:postcode,:direction,:buy_status,
				:pay_type,:postage,:total_price,:customer_id, [order_items_attribute: [:product_id, :quantity, :make_status, :tax_indlueded_price]])

		end
end
