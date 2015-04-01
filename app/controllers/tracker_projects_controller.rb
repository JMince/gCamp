class TrackerProjectsController < ApplicationController
  def show
    @tracker_api = TrackerAPI.new
    @tracker_projects = @tracker_api.projects(current_user.pivotal_token)
  end


end
