class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :auth

  def current_user
    if session[:user_id].present?
      @user = User.find(session[:user_id])
    end
  end

  def auth
    unless current_user
      redirect_to sign_in_path
      flash[:danger] = "You must sign in"
    end
  end
  
end
