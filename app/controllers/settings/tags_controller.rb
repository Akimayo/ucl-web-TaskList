class Settings::TagsController < ApplicationController
    before_action :authenticate_user!
    def index
        @tags = Tag.all
    end
    def show
        @tag = Tag.find(params[:id])
    end
    def new
        @tag = Tag.new
    end
    def edit
        @tag = Tag.find(params[:id])
    end
    def create
        @tag = Tag.new(tag_params)
        if(@tag.save) then redirect_to tags_path
        else render 'new' end
    end
    def update
        @tag = Tag.find(params[:id])
        if(@tag.update(tag_params)) then redirect_to @tag
        else render 'edit' end
    end
    def destroy
        @tag = Tag.find(params[:id])
        @tag.destroy
        redirect_to tags_path
    end

    private
    def tag_params
        params.require(:tag).permit(:title, :color)
    end
end
