class ArticlesController < ApplicationController
  include ArticlesHelper

  before_filter :require_login, except: [:index, :show, :by_month, :popular, :feed]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @article.count_view
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_user
    if @article.save
      flash.notice = "Article #{@article.title} created!"
      redirect_to article_path(@article)
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash.notice = "Article #{@article.title} deleted!"
      redirect_to articles_path
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash.notice = "Article #{@article.title} updated!"
      redirect_to articles_path(@article)
    end
  end

  def by_month
    @articles = Article.order created_at: :desc
    @articles_by_month = {}
    @articles.each do |article|
      @articles_by_month[article.created_at.month] ||= []
      @articles_by_month[article.created_at.month] << article
    end
  end

  def popular
    @articles = Article.order(view_count: :desc).limit(3)
  end

  def feed
    @articles = Article.all
    respond_to do |format|
      format.rss { render "feed.rss.builder" }
      format.html
    end
  end

end
