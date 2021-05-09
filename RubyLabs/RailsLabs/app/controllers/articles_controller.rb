class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def new
    @name = params['name']
    @article = Article.new
    # prefix_path => relative path
    # prefix_url => full path
  end

  # def create
  #   render plain: params[:article].inspect
  # end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # @article = Article.new(article_params)
    @article = current_user.articles.build(article_params)
    @article.save
    if @article.save
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
