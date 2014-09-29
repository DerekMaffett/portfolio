class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:update, :destroy]
  after_action :verify_authorized, only: [:new, :create, :update, :edit]
  after_action :verify_policy_scoped, only: [:index, :show]

  def index
    @articles = policy_scope(Article)
  end

  def show
    @article = policy_scope(Article).find(params[:id])
  end

  def new
    @article = Article.new
    authorize @article
  end

  def edit
    @article = policy_scope(Article).find(params[:id])
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
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow
  # the white list through.
  def article_params
    params.require(:article).permit(
      *policy(@article || Article).permitted_attributes)
  end
end
