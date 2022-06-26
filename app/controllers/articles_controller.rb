class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # add slug to article...
    @article.slug = gen_slug(@article)
    if @article.save
      redirect_to @article # use redirect_to when mutating app state, rather than render...
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end

  private

  def set_article
    @article = Article.find_by(slug: params[:slug])
  end

  def gen_slug(article)
    random_id = SecureRandom.urlsafe_base64(4)
    title_slug = article.title.downcase.tr(' ', '-')
    [random_id, title_slug].join('-')
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
