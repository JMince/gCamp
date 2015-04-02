require 'rails_helper'

describe ProjectsController do

  before {session[:user_id] = user.id}
  let(:user) {create_user}
  let(:project) {create_project}
  let(:owner) { create_membership }
  let(:member) {create_membership(role: 2)}

  describe 'GET #index' do
    before{user}
    before{member}
    before{project}
    it 'creates a projects array' do
      get :index
      expect(assigns(:projects)).to eq user.projects
    end

    before do
      @tracker_api = TrackerAPI.new
    end

    it 'invalid token error' do
      tracker_projects = @tracker_api.projects("5748cea3b98cd0cfe1a708e9a753")
      expect(tracker_projects[:error]).to eq("Invalid authentication credentials were presented.")
    end
  end

  describe 'GET #new' do
    it 'creates a project' do
      project
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe 'POST #create' do
    it 'persists a project to DB' do
      project = {name: "testproject"}
      post :create, project: project
      expect(assigns(:project)).to eq Project.find_by_name("testproject")
    end

    it 'invalid project does not persist to DB ' do
      project = {name: nil}
      post :create, project: project
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do

    it 'owner can edit a project' do
      owner
      user.reload
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'PUT #update' do

    it 'if owner valid changes are permited' do
      owner
      put :update, id: project.id, project: {name: "TestProject"}
      project.reload
      expect(project.name).to eq('TestProject')
    end
  end

  describe 'DElETE #destroy' do

    it 'if owner - destroys a project' do
      owner
      expect {delete :destroy, id:project}.to change{Project.all.count}.by(-1)
    end
  end

end
