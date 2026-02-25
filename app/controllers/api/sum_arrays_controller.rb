module Api
    class SumArraysController < ApplicationController
        def calculate_array_sum
            numbers = Array(params[:sum_arrays]).map(&:to_i)
            total = calculate_sum(numbers)

            render json: {
                sum_arrays: numbers,
                total: total
            }
        end

        private

        def calculate_sum(numbers)
            numbers.sum
        end
    end
end
