class AboutController < PublicController
  def index
    @projects = Project.all
    @users = User.all
    @comments = Comment.all
    @members = Membership.all
    @tasks = Task.all


  end
end
