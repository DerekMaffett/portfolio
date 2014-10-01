class CommentsController < ApplicationController
  def index
    # REMOVE ALONG WITH ROUTES
  end

  def show
    # REMOVE ALONG WITH ROUTES
  end

  def new

  end

  def create
    @article = ArticlePolicy::Scope.new(current_user, Article).resolve.find(
      params[:article_id])
    @comment = @article.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Thank you for commenting. Your comment has
        been received and is awaiting review."
    else
      flash[:alert] = "Invalid comment. Please revise and resubmit."
    end
    redirect_to @article
  end

  def edit

  end

  def update

  end

  def destroy

  end

private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
