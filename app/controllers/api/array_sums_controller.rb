module Api
  # Handles array summation operations
  class ArraySumsController < ApplicationController
    # GET /api/array_sums
    # Accepts an array of integers via the array_to_sum query param
    # and returns the parsed values along with their total.
    def calculate_array_sum
      raw = Array(params[:array_to_sum])
      numbers = validate_and_parse(raw)

      render json: {
        array_to_sum: numbers,
        total: numbers.sum
      }
    rescue ArgumentError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    private

    # Validates that each value is a valid integer, then parses it.
    # Raises ArgumentError immediately if any value is non-numeric.
    def validate_and_parse(raw)
      raw.map do |val|
        raise ArgumentError, "Invalid value: '#{val}' is not a valid integer" unless val.to_s.match?(/\A-?\d+\z/)
        val.to_i
      end
    end
  end
end
