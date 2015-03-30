class ProjectsController < ApplicationController
  before_action :auth
  before_action :set_project, only: [:edit, :show, :update, :destroy]
  before_action :project_owner_auth, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end


  def new
    @project = Project.new
  end


    def create
      @project = Project.new(project_params)
      if @project.save
        flash[:notice] = 'Project was successfully created'
        redirect_to project_tasks_path(@project)
        @project.memberships.create!(role: 2, user_id: current_user.id)
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
    project=Project.find(params[:id])
    if project.destroy
      flash[:notice] = 'Project was successfully deleted'
      redirect_to projects_path
    end
  end



  private

  def set_project
    @project=Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

  def project_owner_auth
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(role: 1) || current_user.permission == true)

      flash[:danger] = "You do not have access to that project"
      redirect_to projects_path
    end
  end



end
