namespace :cleanup do

  desc 'remove membership when user is deleted'
    task removes_empty_user_memberships: :environment do
      existing_users=User.pluck(:id)
      Membership.where.not(user_id: existing_users).destroy_all
  end


  desc 'remove membership when project has been deleted'
    task removes_empty_project_memberships: :environment do
      existing_projects=Project.pluck(:id)
      Membership.where.not(project_id: existing_projects).destroy_all
  end


  desc 'remove tasks where project has been deleted'
    task removes_empty_project_tasks: :environment do
      existing_projects=Project.pluck(:id)
      Task.where.not(project_id: existing_projects).destroy_all
  end


  desc 'removes all comments where task is deleted'
  task removes_empty_task_comments: :environment do
    existing_tasks=Task.pluck(:id)
    Comment.where.not(task_id: existing_tasks).destroy_all
  end


  desc 'set user id to nil on comment if user is deleted'
    task set_user_id_to_nil_when_user_deleted: :environment do
      existing_users=User.pluck(:id)
      Comment.where.not(user_id: existing_users) do
        Comment.user.id = nil
      end
    end


    desc 'removes any task with null project_id'
      task remove_task_with_null_project_id: :environment do
        Task.where(project_id: nil).destroy_all
    end


    desc 'removes comments with null task_id'
      task remove_comment_with_null_task: :environment do
          Comment.where(task_id: nil).destroy_all
    end

    desc 'removes memberships with null project or user_id'
      task remove_membership_with_null_project_or_user: :environment do
        Membership.where("project_id = ? or user_id = ?", nil, nil).destroy_all
    end


end
