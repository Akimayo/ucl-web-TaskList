class Settings::TagsController < ApplicationController
    before_action :authenticate_user!, :settings_tags_path, only: [:show, :edit, :update, :destroy]
    add_breadcrumb "Nastavení", :settings_path
    add_breadcrumb "Značky", :settings_tags_path
    def index
        # BEWARE: Default tags have a `bell` character at the beginning of their title, so they appear before other tags
        @tags = current_user.tags.all.includes(:tag_associations, :tasks).order(:title)
    end
    def show
        @tag = current_user.tags.find(params[:id])
        add_breadcrumb @tag.title
    end
    def new
        @tag = Tag.new
        @save_path = settings_tags_path
        add_breadcrumb "Nová značka"
    end
    def edit
        @tag = current_user.tags.find(params[:id])
        @save_path = settings_tag_path(@tag)
        add_breadcrumb @tag.title
    end
    def create
        p params
        @tag = current_user.tags.new(tag_params)
        if(@tag.save) then redirect_to settings_tags_path
        else render 'new' end
    end
    def update
        @tag = current_user.tags.find(params[:id])
        if(@tag.update(tag_params)) then redirect_to settings_tag_path(@tag)
        else render 'edit' end
    end
    def destroy
        @tag = current_user.tags.find(params[:id])
        @tag.destroy
        redirect_to settings_tags_path
    end

    private
    def tag_params
        params.require(:tag).permit(:title, :color)
    end
end
