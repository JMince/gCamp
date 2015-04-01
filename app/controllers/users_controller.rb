class UsersController < ApplicationController
  before_action :auth
  helper_method :match_users
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :render_404, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User was successfully created"
      redirect_to users_path(@user)
    else
      render:new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "User was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    if current_user == @user
      session.clear
      @user.destroy
      flash[:notice] = "User was successfully deleted"
      redirect_to root_path
    else

      @user.destroy
      flash[:notice] = "User was succesfully deleted"
      redirect_to users_path
    end
  end



  private

  def user_params
    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin, :pivotal_token)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :pivotal_token)
    end
  end

  def match_users(user)
    (current_user.memberships.pluck(:project_id) & user.memberships.pluck(:project_id)).empty?
  end

  def current_user_or_admin
    @current_user.id == @user.id
  end

  def set_user
      @user = User.find(params[:id])
  end

  def render_404
    unless current_user.id == @user.id || current_user.admin
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end


end
