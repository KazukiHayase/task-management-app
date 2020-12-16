class UsersController < ApplicationController
    before_action :get_user, only: [:show]

    def index
        @users = User.all.includes(:tasks)
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
    
    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def get_user
        @user = User.find(params[:id])
    end
end
