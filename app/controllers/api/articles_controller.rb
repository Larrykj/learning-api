module Api
    class ArticlesController < ApplicationController
        before_action :set_article, only: [:show, :edit, :update, :destroy]
        before_action :require_login, except: [:index, :show]
        def index
            @articles = Article.all
        end

        def show
            @article = Article.find([params:id])
        end
         
        def new
            @article = Article.new
        end

        def create
            @article = Article.new(article_params)
            if @article.save
                redirect_to @article, notice: "Article Created!"
            else
                render :new, status:unprocessable_entity
            end
        end

        def edit
            @article = Article.find(params[:id])
        end

        def update
            @article = Article.find(params[:id])
            if @article.update(article_params)
                redirect_to @article, notice: "Article updated"
            else
                render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path, notice: "Article deleted!"
    end

    private

    def article_params
        params.require(:article).permit(:title, :body)
    end

    def show
        # URL: /articles/42
        @article = Article.find(params[:id]) # params[:id] => "42"
    end

    def index
        # URL: /articles?sort=recent
        @sort = params[:sort] # => "recent"
    end

    private

    def article_params
        params.require(:article).permit(:title, :body, :published)
    end

    def show
        #@article is already set!
    end

    def edit
         # @article is already set!
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def require_login
        redirect_to login_path unless current_user
    end

    def show
        @article = Article.find(params[:id])

        respond_to do |format|
            format.html # renders show.html.erb
            format.json { render json: @article }
            format.xml { render xml: @article }
        end
end 
end
