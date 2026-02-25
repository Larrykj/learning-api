module Api
  # Handles array summation operations
  class SumArraysController < ApplicationController
    # GET /api/calculate_array_sum
    # Accepts an array of integers via the sum_arrays query param
    # and returns the parsed values along with their total.
    def calculate_array_sum
      numbers = Array(params[:sum_arrays]).map(&:to_i)
      total = calculate_sum(numbers)

      render json: {
        sum_arrays: numbers,
        total: total
      }
    end

    private

    # Sums all elements in the given array of integers
    def calculate_sum(numbers)
      numbers.sum
    end
  end
end
