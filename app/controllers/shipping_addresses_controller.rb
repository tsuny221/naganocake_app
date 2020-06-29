class ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!

 def index
    @customer = current_customer
  	@shipping_addresses = @customer.shipping_addresses
  	@shipping_address = ShippingAddress.new
 end

 def create
  	 @shipping_address = ShippingAddress.new(shipping_address_params)
     @shipping_address.customer_id = current_customer.id
     if @shipping_address.save
  	   flash[:notice] = "配送先を追加しました"
  	   redirect_to shipping_addresses_path(@shipping_address)
     else
       @customer = current_customer
       @shipping_addresses = @customer.shipping_addresses
       render :index
     end
  end


  def edit
      @shipping_address = ShippingAddress.find(params[:id])
      if @shipping_address.customer != current_customer
        redirect_to shipping_addresses_path
      end
  end

  def destroy
      shipping_address = ShippingAddress.find(params[:id])
      shipping_address.destroy
      flash[:notice] = "配送先を削除しました"
      redirect_to shipping_addresses_path
  end
  def update
      @shipping_address =ShippingAddress.find(params[:id])
      if @shipping_address.update(shipping_address_params)
        flash[:notice] = "配送先を更新しました"
        redirect_to shipping_addresses_path(@shipping_address.id)
      else
        render :edit
     end
  end

   private
  def shipping_address_params
  	params.require(:shipping_address).permit(:postcode, :address, :direction)
  end
end

