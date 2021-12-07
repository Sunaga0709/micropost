class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 10)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを作成しました。'
      redirect_to root_url
    else
      flash[:danger] = 'ユーザの作成に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザを編集しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザの編集に失敗しました。'
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'ユーザを削除しました。'
    redirec_to root_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
