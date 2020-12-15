class TasksController < ApplicationController
  before_action :require_login
  before_action :get_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @current_user.tasks.order(created_at: :desc).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "タスクを作成しました！"
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを編集しました！"
      redirect_to @task
    else
      render "edit"
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクを削除しました！"
    redirect_to tasks_path
  end

  def sort
    sort_data = params[:sort_data].split("_")
    column = sort_column(sort_data[0])
    direction = sort_direction(sort_data[1])
    @tasks = @current_user.tasks.sorted_by(column, direction).page(params[:page])
    @paginate_method = :post

    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end
  
  def search
    search_params = {keyword: params[:keyword], status: params[:status]}
    @tasks = @current_user.tasks.search(search_params).page(params[:page])
    @paginate_method = :post
    
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end
  
  private

    def task_params
      params.require(:task).permit(:name, :content, :deadline, :status, :priority)
    end

    def sort_column(column)
        Task.column_names.include?(column) ? column : "created_at"
    end

    def sort_direction(direction)
        %w[asc desc].include?(direction) ? direction : "desc"
    end

    def get_task
      @task = Task.find(params[:id])
    end

    def require_login
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_path
      end
    end
end
