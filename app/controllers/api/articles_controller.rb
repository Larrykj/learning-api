module Api
  class ArticlesController < ApplicationController
    def index
      render json: {
        message: "Articles API endpoint",
        articles: []
      }
    end

    def show
      render json: {
        id: params[:id],
        message: "Article details would go here"
      }
    end
  end
end
