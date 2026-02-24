module Api
  class SumArraysController < ApplicationController
    def calculate_array_sum
      values = Array(params[:sum_arrays]).map(&:to_i)

      render json: {
        sum_arrays: values,
        total: values.sum
      }
    end
  end
end
