module Api
  class ChangesController < ApplicationController::API
    def check
      # Accept either ?changes=63 or ?calculate_status=63
      number = (params[:changes] || params[:calculate_status]).to_i

      # Call the private method logic
      status = calculate_status(number)

      # Render the JSON response
      render json: {
        number: number,
        status: status,
        is_even: number.even?
      }
    end

    def reverse
      original = params[:input_string].to_s
      reversed = original.reverse

      render json: {
        original: original,
        reversed: reversed
      }
    end

    def convert
      number = (params[:calculate_even] || params[:compute]).to_i
      status = calculate_status(number)

      render json: {
        number: number,
        status: status,
        is_even: number.even?
      }
    end

    private

    # This method is hidden from the outside world (encapsulation)
    def calculate_status(n)
      n % 2 == 0 ? "even" : "odd"
    end
  end
end
