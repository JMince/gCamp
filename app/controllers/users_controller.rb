class UsersController < ApplicationController

  before_action :auth
  helper_method :match_users

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
    @user = User.find(params[:id])
  end



  def edit
@user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "User was successfully updated"
    else
      render :edit
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User was succesfully deleted"
    redirect_to users_path
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

end
