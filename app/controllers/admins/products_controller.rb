class Admins::ProductsController < ApplicationController
before_action :authenticate_admin!

def show
	@product = Product.find(params[:id])
end

def index
	@products = Product.page(params[:page]).reverse_order

end

def new
	@product = Product.new
	@categories = Category.where(active_status: :true)
end

def create
	@product = Product.new(product_params)
	if @product.save
	flash[:notice] = "商品を追加しました"
	redirect_to admins_product_path(@product)
	else
		@categories = Category.where(active_status: :true)
		render :new
	end
end

def edit
	@product = Product.find(params[:id])
	@categories = Category.where(active_status: :true)
end



def update
	@product = Product.find(params[:id])
	if @product.update(product_params)
	  flash[:notice] = "商品を更新しました"
	  redirect_to admins_products_path
	else
	  render :edit
	end
end

def destroy
	@product = Product.find(params[:id])
	@product.destroy
	redirect_to admins_products_path
end

private

def product_params
	params.require(:product).permit(:name,:description,:price,:image,:category_id,:sale_status)
end



end
