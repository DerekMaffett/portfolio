class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @article = Pundit.policy_scope(current_user, Article).find(
      params[:article_id])
    @comment = @article.comments.build(comment_params)
    if @comment.save
      flash[:notice] = 'Thank you for commenting. Your comment has
        been received and is awaiting review.'
    else
      flash[:alert] = 'Invalid comment. Please revise and resubmit.'
    end
    redirect_to @article
  end

  def approve
    @article = Pundit.policy_scope(current_user, Article).find(
      params[:article_id])
    @comment = policy_scope(@article.comments).find(params[:id])
    authorize @comment
    @comment.update(approved: true)
    redirect_to @article
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
