require 'rails_helper'

describe TasksController do

  before {session[:user_id] = user.id}
  let(:user) {create_user}
  let(:project) {create_project}
  let!(:member) {create_membership(role:2, user_id:user.id, project_id: project.id)}
  let!(:task) {create_task(project_id:project.id)}


  describe 'GET #index' do
   it 'populates an array of tasks' do
     get :index, project_id:project.id
     expect(assigns(:tasks)).to eq [task]
   end
  end

  describe 'POST #create' do
   it 'creates a task instance' do
     task_hash = {description: 'description', completed: 'false', date: "2019-07-03", project_id: project.id}
     post :create, project_id: project.id, task: task_hash

     expect(assigns(:task)).to eq Task.find_by_description('description')
   end
  end

  describe 'GET #new' do
   it 'creates a new task instance' do
     get :new, project_id: project.id

     expect(assigns(:task)).to be_a_new(Task)
   end
  end

  describe 'GET #edit' do
   it 'locates a task' do
     get :edit, project_id: project.id, id: task.id
     expect(assigns(:task)).to eq(task)
   end
  end

  describe 'GET #show' do
   it 'show action - gets a task' do
     get :edit, project_id: project.id, id: task.id
     expect(assigns(:task)).to eq(task)
   end
  end

  describe 'PUT #update' do
   it '' do
     put :update, project_id: project.id, id: task.id, task: {description: "I like this description better"}
     expect(task.reload.description).to eq("I like this description better")
   end
  end

  describe 'DELETE #destroy' do
     it 'destroys a task' do
       expect {delete :destroy, project_id: project.id, id: task.id}.to change{Task.all.count}.by(-1)
     end
   end

  describe 'non-members get redirected' do
    before {project.memberships.destroy_all}
    before {task}

    it 'if  get action' do

      actions = [:index, :show, :edit]
      actions.each do |action|
        get action, project_id: project.id, id: task.id

        expect(response).to redirect_to(projects_path)
      end
    end

    it 'if put action' do

      put :update, project_id: project.id, id: task.id, task: {description: "description"}

      expect(response).to redirect_to(projects_path)
    end

    it 'if delete action' do

      delete :destroy, project_id: project.id, id: task.id

      expect(response).to redirect_to(projects_path)
    end
  end

  describe 'unauthorized users get redirected' do

    before {session.clear}

    it 'if get action' do

      actions = [:index, :new, :edit, :show]
      actions.each do |action|
        get action, project_id: project.id, id: task.id

        expect(response).to redirect_to(sign_in_path)
      end
    end

    it 'if put action' do
      put :update, project_id: project.id, id: task.id, task: {description: "description"}

      expect(response).to redirect_to(sign_in_path)
    end

    it 'if post action' do
      post :create, project_id: project.id, id: task.id

      expect(response).to redirect_to(sign_in_path)
    end

    it 'if delete action' do
      delete :destroy, project_id: project.id, id: task.id

      expect(response).to redirect_to(sign_in_path)
    end
  end

  end
