class Admins::CategoriesController < ApplicationController
	before_action :authenticate_admin!, only: [:index, :create, :edit, :destroy]

	def index
		@category = Category.new
		@categories = Category.all.page(params[:page]).reverse_order
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "カテゴリーを追加しました"
			redirect_to admins_categories_path
		else
		  @categories = Category.all
		  render :index
		end
	end

	def show
		@category = Category.find(params[:id])
		@products = @category.products.page(params[:page]).reverse_order
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update(category_params)
			flash[:notice] = "カテゴリーを更新しました"
			redirect_to admins_categories_path
		else
		　render :edit
		end
	end

	private
	def category_params
		params.require(:category).permit(:name, :active_status, :product_id)
	end

end