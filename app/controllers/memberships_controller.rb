class MembershipsController < ApplicationController

  before_action :find_and_set_project
  before_action :limit_actions
  before_action :set_membership, only: [ :show, :edit, :update, :destroy]


    def index
      @memberships = @project.memberships
      @membership = @project.memberships.new
      @project_name = @project.name
    end


    def create
      @membership = @project.memberships.new(membership_params)
      if @membership.save
        flash[:notice] = "#{@membership.user.full_name} has been successfully added"
        redirect_to project_memberships_path(@project)
      else
        render :index
      end
    end


    def update
     if owner_count(@project) == 1 && @membership.role == 1
       flash[:danger] = "Projects must have at least one owner"
       redirect_to project_memberships_path(@project.id)
     elsif @membership.update(membership_params)
       redirect_to project_memberships_path(@project.id)
     else
       render :index
     end
   end

    def destroy
      membership = Membership.find(params[:id])
      if Membership.find_by(project_id: @project.id, user_id: current_user.id, role: 1) || current_user.admin || current_user == membership.user 
        membership.destroy
        flash[:notice] = "#{membership.user.full_name} was successfully removed"
        redirect_to projects_path
      else
        flash[:notice] = "You do not have access"
        redirect_to project_path(@project)
      end
    end





private

def set_membership
   @membership = @project.memberships.find(params[:id])
 end

def membership_params
  params.require(:membership).permit(:user_id, :project_id, :role)
end



def find_and_set_project
  @project = Project.find(params[:project_id])
end


end
