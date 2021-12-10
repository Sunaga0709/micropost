class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :current_page, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(post_params)

    if @micropost.save
      flash[:success] = 'Posted.'
      redirect_to root_url
    else
      flash.now[:danger] = 'Not posted.'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Deleted.'
    redirect_to root_url
  end

  private

  def post_params
    params.require(:micropost).permit(:content)
  end

  def current_user
    @micropost = current_user.microposts.find_by(id: params[:id])

    unless @micropost
      flash[:danger] = 'Not found.'
      redirect_to root_url
    end
  end
end
