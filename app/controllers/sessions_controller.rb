class SessionsController < ApplicationController
  before_action :get_user, only: [:create]

  def new
  end

  def create
    if @user.authenticate(params[:session][:password])
      login(@user)
      flash[:success] = "ログインしました"
      redirect_to tasks_path
    else
      flash.now[:warnig] = "パスワードが違います"
      render "new"
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトしました"
    redirect_to login_path
  end

  private

  def get_user
    unless @user = User.find_by(email: params[:session][:email])
      flash.now[:warnig] = "登録されてないメールアドレスです"
      render "new"
    end
  end
end
