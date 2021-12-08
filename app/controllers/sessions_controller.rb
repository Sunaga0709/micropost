class SessionsController < ApplicationController
  before_action :require_user_logged_in, only: [:destroy]

  def new
  end

  def create
    email = params[:session][:email].downcase
    pass = params[:session][:password]

    if login(email, pass)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, pass)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(pass)
      session[:user_id] = @user.id
      return true
    else
      false
    end
  end
end
