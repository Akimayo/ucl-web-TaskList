class TasksController < ApplicationController
    before_action :authenticate_user!
    add_breadcrumb "Úkoly", :tasks_path
    def index
        # BEWARE: Default tasks have a `bell` character at the beginning of their title, so they appear before other tasks
        @list = List.new
        @tasks = @list.filter(params.has_key?("list") ? (task_filters) : nil, current_user)
        if params.has_key?(:list) && params[:list][:group_by] == "1"
            # Paginates by four categories because it can't count the tasks
            @tasks[:collection] = @tasks[:collection].paginate(page: params.has_key?(:page) ? params[:page] : 1, per_page: 4)
            @display_ungrouped = params[:page].to_i == @tasks[:collection].total_pages.to_i
            @display_ungrouped = true if @tasks[:collection].total_pages.to_i <= 1
        else @tasks = @tasks.paginate(page: params.has_key?(:page) ? params[:page] : 1, per_page: 30) end
    end
    def show
        @task = current_user.tasks.find(params[:id])
        add_breadcrumb @task.title
    end
    def new
        @task = current_user.tasks.new(is_done: false)
        add_breadcrumb "Nový úkol"
    end
    def edit
        @task = current_user.tasks.find(params[:id])
        add_breadcrumb @task.title
    end
    def create
        @task = current_user.tasks.new(task_params)
        if(@task.save) then redirect_to @task
        else render 'new' end
    end
    def update
        @task = current_user.tasks.find(params[:id])
        if(@task.update(task_params))
            if(params.has_key?("redirect_to_index") && params["redirect_to_index"]) then redirect_to tasks_path
            else redirect_to @task end
        else render 'edit' end
    end
    def destroy
        if(params.has_key?(:id) && params[:id].to_i > 0) 
            @task = current_user.tasks.find(params[:id])
            @task.destroy
        else
            d = params.require(:delete).permit!().to_hash().to_a().map { |i| i[0] if i[1].to_i > 0 }
            current_user.tasks.destroy(current_user.tasks.where(id: d))
        end
        redirect_to tasks_path
    end

    private
    def task_params
        params.require(:task).permit(:title, :note, :deadline_at, :category_id, :is_done, { tag_ids: [] })
    end
    def task_filters
                                                                                                                       # Because it just cannot be that simple, right, :is_done..?
        params.require(:list).permit(:search, { categories: [] }, { tags: [] }, :order_by, :order_direction, :group_by, {is_done: []})
    end
end
