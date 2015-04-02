def create_user(overrides={})
  defaults = {
    first_name: "test",
    last_name: "test",
    email: "test@test.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    pivotal_token: "5748cea3b98cd0cfe1a708e9a75327f7"
  }
  User.create!(defaults.merge(overrides))
end

def create_task(overrides = {})
  defaults = {
    project_id: create_project.id,
    description: 'Test project',
    date: '2015-06-04'
  }
  Task.create!(defaults.merge(overrides))
end

def create_membership(overrides = {})
 defaults = {project_id: project.id,
   user_id: user.id,
   role: 1 }
 Membership.create!(defaults.merge(overrides))
end

def create_project(overrides={})
 defaults = {name: "ProjectTest"}
 Project.create!(defaults.merge(overrides))
end
