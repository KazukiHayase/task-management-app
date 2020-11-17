class TasksController < ApplicationController
  def index
    @tasks = Task.all
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
      redirect_to tasks_path
      flash[:success] = "タスクの作成が完了しました！"
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
      redirect_to @task
      flash[:success] = "タスクの編集が完了しました！"
    else
      render "edit"
    end
  end
  
  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "タスクの削除が完了しました！"
    redirect_to tasks_path
  end
  
  


  private

    def task_params
      params.require(:task).permit(:name, :content)
    end
    
  
end
