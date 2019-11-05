class Settings::CategoriesController < ApplicationController
    before_action :authenticate_user!
    def index
        @categories = Category.all
    end
    def show
        @category = Category.find(params[:id])
    end
    def new
        @category = Category.new
    end
    def edit
        @category = Category.find(params[:id])
    end
    def create
        @category = Category.new(category_params)
        if(@category.save) then redirect_to categories_path
        else render 'new' end
    end
    def update
        @category = Category.find(params[:id])
        if(@category.update(category_params)) then redirect_to @category
        else render 'edit' end
    end
    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        redirect_to categories_path
    end

    private
    def category_params
        params.require(:category).permit(:title, :color)
    end
end
