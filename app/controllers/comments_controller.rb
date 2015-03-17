class CommentsController < ApplicationController


  def create
    @task = Task.find(params[:task_id])
    @comment = Comment.new(comment_params)
    if @comment.save
    redirect_to project_task_path(@task.project.id, @task)
    else
    redirect_to project_task_path(@task.project.id, @task)
  end
end









  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, task_id: @task.id)
  end



end
