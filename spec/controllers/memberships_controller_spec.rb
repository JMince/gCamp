require 'rails_helper'

describe MembershipsController do


  User.destroy_all
  before {session[:user_id] = user.id}
  let(:user1) { create_user(email: "curly@test.com") }
  let(:user) {create_user}
  let(:project) {create_project}
  let(:member) {create_membership({user_id: user1.id, role: 2})}
  let!(:owner) {create_membership}


  describe 'POST #create' do
    it 'a new instance of a membership created' do
      member_new = { user_id: user1.id, role: 1}

      post :create, project_id: project.id, id: Membership.last.id, membership: member_new

      expect(assigns(:membership)).to eq Membership.last
    end

    it 'does not persist an invalid membership' do

      bad_membership = {project_id: nil, user_id: nil, role: nil}

      post :create, project_id: project.id, id: Membership.last.id, membership: bad_membership

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #update' do
    it 'persists valid changes to DB' do
      put :update, project_id: project.id, id: member.id, membership: {role: 1}

      expect(member.reload.role).to eq(1)
    end

    it 'tests does not persist invalid changes' do
      put :update, project_id: project.id, id:member.id, membership: {user_id: nil}
      member.reload
      expect(member.user_id).to eq(user1.id)
    end

    it 'tests changing last owner role does not persist to DB' do
      post :update, project_id: project.id, id:owner.id, membership: {role: 2}
      expect(owner.role).to eq(1)
    end

  end

  describe 'DELETE #destroy' do
    before{member}

    it 'destroys a membership' do
      expect {delete :destroy, project_id: project.id, id: member.id}.to change {Membership.all.count}.by(-1)
    end

    it 'does not destroy last owner' do
      expect {delete :destroy, project_id: project.id, id: owner.id}.to change {Membership.all.count}.by(0)
    end
  end

  describe 'members get redirected' do
    before{owner.destroy}
    before{member}

    it 'tests index requires user to have owner membership' do
      get :index, project_id: project.id

      expect(response).to redirect_to(projects_path)
    end
  end


end
