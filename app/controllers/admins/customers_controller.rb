class Admins::CustomersController < ApplicationController
before_action :authenticate_admin!

	def index
		@customers = Customer.page(params[:page]).reverse_order
    end

    def show
    	@customer = Customer.find(params[:id])
    	@customers = Customer.all
    end

    def edit
    	@customer = Customer.find(params[:id])
    end

    def update
        @customer = Customer.find(params[:id])
       if @customer.update(customer_params)
          flash[:notice] = "登録情報を更新しました"
          redirect_to admins_customer_path(@customer)
       else
          render :edit
       end
    end
   
    private
    def customer_params
    	params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, :phone_number, :email, :account_status, :customer_id)
    end

end
