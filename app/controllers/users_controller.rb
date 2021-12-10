class UsersController < ApplicationController
  before_action :require_user_logged_in, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 10)
  end

  def show
    @pagy, @microposts = pagy(@user.microposts.order(id: :desc))
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'Created user.'
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = 'Fail...'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Edited user.'
      redirect_to @user
    else
      flash[:danger] = 'Fail edit user.'
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'Deleted user.'
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
