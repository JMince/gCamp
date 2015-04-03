require 'rails_helper'

describe UsersController do


  before {session[:user_id] = user.id}
  let(:user) {create_user}
  let(:project) {create_project}
  let!(:member) {create_membership(role:2, user_id:user.id, project_id: project.id)}
  let!(:task) {create_task(project_id:project.id)}


  describe 'GET #index' do
   it 'populates an array of users' do
     get :index, project_id:project.id
     expect(assigns(:users)).to eq [user]
   end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      bob = {first_name: "Marlon", last_name: "Brando", email: "marlin@brando.com", password: "password"}
      post :create, user: bob

      expect(assigns(:user)).to eq User.find_by_first_name("Marlon")
      expect(response).to redirect_to(users_path)
    end
  end

  describe 'GET #new' do
   it 'creates a new user instance' do
     get :new, project_id: project.id

     expect(assigns(:user)).to be_a_new(User)
   end
  end

  describe 'GET #edit' do
   it 'locates a user' do
     get :edit, project_id: project.id, id: user.id
     expect(assigns(:user)).to eq(user)
   end
  end

  describe 'GET #show' do
   it 'show action - gets a user' do
     get :edit, project_id: project.id, id: user.id
     expect(assigns(:user)).to eq(user)
   end
  end

  describe 'PUT #update' do
   it 'user can update user' do
     put :update, project_id: project.id, id: user.id, user: {first_name: "Billy Bob"}
     expect(user.reload.first_name).to eq("Billy Bob")
   end
  end

  describe 'DELETE #destroy' do
     it 'destroys a user' do
       expect {delete :destroy, project_id: project.id, id: user.id}.to change{User.all.count}.by(-1)
     end
   end

  describe 'non-members get redirected' do
    before {project.memberships.destroy_all}
    before {user}

    it 'if put action' do

      put :update, project_id: project.id, id: user.id, user: {description: "description"}

      expect(response).to redirect_to(user_path user)
    end

    it 'if delete action' do

      delete :destroy, project_id: project.id, id: user.id

      expect(response).to redirect_to(root_path)
    end
  end

  describe 'unauthorized users get redirected' do

    before {session.clear}

    it 'if get action' do

      actions = [:index, :new, :edit, :show]
      actions.each do |action|
        get action, project_id: project.id, id: user.id

        expect(response).to redirect_to(sign_in_path)
      end
    end

    it 'if put action' do
      put :update, project_id: project.id, id: user.id, user: {description: "description"}

      expect(response).to redirect_to(sign_in_path)
    end

    it 'if post action' do
      post :create, project_id: project.id, id: user.id

      expect(response).to redirect_to(sign_in_path)
    end

    it 'if delete action' do
      delete :destroy, project_id: project.id, id: user.id

      expect(response).to redirect_to(sign_in_path)
    end
  end


 end
