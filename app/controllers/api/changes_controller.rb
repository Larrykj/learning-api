module Api
  class ChangesController < ApplicationController::API
    def check
      # Grab 'changes' from query params (e.g., ?changes=63)
      number = params[:changes].to_i

      # Call the private method logic
      status = calculate_status(number)

      # Render the JSON response
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
