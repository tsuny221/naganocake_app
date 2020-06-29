class Admins::OrderItemsController < ApplicationController


	def update
		@order_item = OrderItem.find(params[:id])
		@order = Order.find_by(id: @order_item.order_id)
		@order_items = OrderItem.where(order_id: @order.id)
		@order_items2 = OrderItem.where(order_id: @order.id).where(make_status: "製作中")
		if params[:order_item][:make_status] == "製作中"
		@order.update(buy_status: "製作中")
		end
		@order_item.update(order_item_params)
		if @order_items2.count == @order_items.count
			@order.update(buy_status: "発送準備中")
		end
		redirect_back(fallback_location: admins_order_path)
	end


private
	def order_item_params
			params.require(:order_item).permit(:order_id, :product_id, :quantity, :make_status, :tax_indlueded_price)
	end
end
