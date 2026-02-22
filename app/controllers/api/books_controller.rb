module Api
    class BooksController < ApplicationController
        def title
            title = params[:title].to_s

            render json: {
                title: title
            }
        end
    end
end
