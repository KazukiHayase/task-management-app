class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを編集しました！"
      redirect_to @task
    else
      render "edit"
    end
  end
  
  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "タスクを削除しました！"
    redirect_to tasks_path
  end

  def sort
    sort_data = params[:sort_data].split("_")
    column = sort_column(sort_data[0])
    direction = sort_direction(sort_data[1])
    @tasks = Task.sorted_by(column, direction)

    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end
  
  def search
    search_params = {keyword: params[:keyword], status: params[:status]}
    @tasks = Task.search(search_params)
    
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end
  
  


  private

    def task_params
      params.require(:task).permit(:name, :content, :deadline, :status)
    end

  
end
