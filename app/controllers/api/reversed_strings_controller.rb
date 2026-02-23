module Api
    class ReversedStringsController < ApplicationController
        def process_string
            original = params[:input_string].to_s
            reversed_string = original.reverse

            render json: {
                original: original,
                reversed_string: reversed_string
            }
        end
    end
end
