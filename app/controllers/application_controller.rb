class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :auth
  helper_method :owner_count

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

  def limit_actions
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(project_id: @project.id))
      flash[:danger] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def owner_count(project)
   project.memberships.where(role:1).count
 end

end
