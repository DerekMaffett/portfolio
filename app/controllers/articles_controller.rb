class ArticlesController < ApplicationController
  before_action :set_scoped_article, except: [:index, :new, :create]
  after_action :verify_authorized, except: [:index, :show]
  after_action :verify_policy_scoped, except: [:new, :create]

  def index
    @articles = policy_scope(Article)
  end

  def show
    @comments = Pundit.policy_scope(current_user, @article.comments)
    @comment = Comment.new
  end

  def new
    @article = Article.new
    authorize @article
  end

  def edit
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    authorize @article
    if @article.save
      current_user.articles << @article
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @article
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @article
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scoped_article
    @article = policy_scope(Article).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow
  # the white list through.
  def article_params
    params.require(:article).permit(
      *policy(@article || Article).permitted_attributes)
  end
end
