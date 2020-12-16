class UsersController < ApplicationController
    before_action :get_user, only: [:show, :edit, :update, :destroy]
    before_action :admin_user

    def index
        @users = User.preload(:tasks)
    end

    def show
        @tasks = @user.tasks.page(params[:page])
    end
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "ユーザーを作成しました！"
            redirect_to users_path
        else
            render "new"
        end
    end

    def edit
    end
    
    def update
        if @user.update_attributes(user_params)
            flash[:success] = "ユーザーを編集しました！"
            redirect_to users_path
        else
            render "edit"
        end
    end
    
    def destroy
        unless @user == current_user
            @user.destroy
            flash[:success] = "ユーザーを削除しました！"
            redirect_to users_path
        end
    end
    
    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def get_user
        @user = User.find(params[:id])
    end

    def admin_user
        raise ApplicationError::NotPermittedError unless current_user.admin?
    end
end
