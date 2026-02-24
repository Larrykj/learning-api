module Api
  class RevisionsController < ApplicationController
    def calculate_even
      number = (params[:calculate_even] || params[:compute]).to_i
      parity = calculate_convert(number)

      render json: {
        number: number,
        parity: parity,
        is_even: number.even?
      }
    end

    private

    def calculate_convert(n)
      n % 2 == 0 ? "even" : "odd"
    end
  end
end
