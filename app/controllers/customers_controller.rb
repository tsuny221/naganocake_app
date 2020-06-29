class CustomersController < ApplicationController
before_action :authenticate_customer!

  def confirm
  end

  def hide
      @customer = Customer.find(params[:id])
      @customer.account_status = false
      @customer.update(is_deleted: true)
      reset_session
      flash[:notice] = "ありがとうございました。またのご利用お待ちしております。"
      redirect_to root_path 
  end

  def show
	  @customer = Customer.find(params[:id])
	  @customer = current_customer
    #パスワードを入力するとホーム画面に戻っちゃう
  end

  def edit
  	  @customer = Customer.find(params[:id])
  	  if @customer != current_customer
      redirect_to _products_path
      end
  end

  def update
      @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
      flash[:notice] = "登録情報を更新しました"
      redirect_to customer_path(@customer.id)
      else
      render :edit
      end
  end

  private
  def customer_params
     params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, :phone_number, :email, :account_status, :is_deleted)
  end
end
