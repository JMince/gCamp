class AuthenticationController < ApplicationController


  def new
    session[:user_id] = nil
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
      flash[:notice] = 'You have successfully signed in'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:notice] = 'You have successfully logged out'
  end


end
