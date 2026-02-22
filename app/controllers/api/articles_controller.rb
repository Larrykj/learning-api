module Api
    class ArticlesController < ApplicationController
    before_action :set_article, only: [ :show, :edit, :update, :destroy ]
    before_action :require_login, except: [ :index, :show ]
            @articles = Article.all
        end

        def show; end

        def new
            @article = Article.new
        end

        def create
            @article = Article.new(article_params)
            if @article.save
                redirect_to @article, notice: "Article Created!"
            else
                render :new, status: :unprocessable_entity
            end
        end

        def edit; end

        def update
            if @article.update(article_params)
                redirect_to @article, notice: "Article updated"
            else
                render :edit, status: :unprocessable_entity
            end
        end

        def destroy
            @article.destroy
            redirect_to articles_path, notice: "Article deleted!"
        end

        private

        def article_params
            params.require(:article).permit(:title, :body, :published)
        end

        def set_article
            @article = Article.find(params[:id])
        end

        def require_login
            redirect_to login_path unless current_user
        end
    end
end
