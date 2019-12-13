class Settings::CategoriesController < ApplicationController
    before_action :authenticate_user!, :settings_categories_path, only: [:show, :edit, :update, :destroy]
    add_breadcrumb "Nastavení", :settings_path
    add_breadcrumb "Kategorie", :settings_categories_path
    def index
        # BEWARE: Default categories have a `bell` character at the beginning of their title, so they appear before other categories
        @categories = current_user.categories.all.includes(:tasks).order(:title)
    end
    def show
        @category = current_user.categories.find(params[:id])
        add_breadcrumb @category.title
    end
    def new
        @category = current_user.categories.new
        @save_path = settings_categories_path
        add_breadcrumb "Nová kategorie"
    end
    def edit
        @category = current_user.categories.find(params[:id])
        @save_path = settings_category_path(@category)
        add_breadcrumb @category.title
    end
    def create
        @category = current_user.categories.new(category_params)
        if(@category.save) then redirect_to settings_categories_path
        else render 'new' end
    end
    def update
        @category = current_user.categories.find(params[:id])
        if(@category.update(category_params)) then redirect_to settings_category_path(@category)
        else render 'edit' end
    end
    def destroy
        @category = current_user.categories.find(params[:id])
        @category.tasks.update(category_id: nil)
        @category.destroy
        redirect_to settings_categories_path
    end

    private
    def category_params
        params.require(:category).permit(:title, :color)
    end
end
