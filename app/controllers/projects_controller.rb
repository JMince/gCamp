class ProjectsController < ApplicationController
  before_action :auth
  before_action :set_project, only: [:edit, :show, :update, :destroy]
  before_action :project_owner_auth, only: [:edit, :update, :destroy]
  before_action :project_member_auth, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
    @tracker_api = TrackerAPI.new
    if current_user.pivotal_token
      @tracker_projects = @tracker_api.projects(current_user.pivotal_token)
    end
  end


  def new
    @project = Project.new
  end


    def create
      @project = Project.new(project_params)
      if @project.save
        flash[:notice] = 'Project was successfully created'
        redirect_to project_tasks_path(@project)
        @project.memberships.create!(role: 1, user_id: current_user.id)
      else
        render :new
      end
    end


  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end


  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = 'Project was successfully updated'
      redirect_to project_path(@project)
    else
      render :edit
    end
  end



  def destroy
    project = Project.find(params[:id])
    project.destroy
      flash[:notice] = 'Project was successfully deleted'
      redirect_to projects_path
  end



  private

  def set_project
    @project=Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :pivotal_token)
  end

  def project_owner_auth
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(role: 1))
      flash[:danger] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def project_member_auth
    unless current_user.projects.include?(@project)
      flash[:danger] = "You do not have access to that project"
      redirect_to projects_path
    end
  end



end
