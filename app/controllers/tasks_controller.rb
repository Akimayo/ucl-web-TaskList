class TasksController < ApplicationController
    before_action :authenticate_user!
    def index
        @tasks = Task.all
    end
    def show
        @task = Task.find(params[:id])
    end
    def new
        @task = Task.new
    end
    def edit
        @task = Task.find(params[:id])
    end
    def create
        @task = Task.new
    end
    def update
        @task = Task.find(params[:id])
        if(@task.update(task_params)) then redirect_to @task
        else render 'edit' end
    end
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
    end

    private
    def task_params
        params.require(:task).permit(:title, :note, :deadline_at)
    end
end
