module Api
  class CarsController < ApplicationController
    rescue_from ActiveRecord::RecordNotUnique, with: :handle_duplicate_id

    def create
      create_params = params[:create_car_params]

      if create_params.blank?
        render json: { error: "Missing required param: create_car_params" }, status: :bad_request
        return
      end

      missing = %w[id make model year].select { |field| create_params[field].blank? }

      if missing.any?
        render json: { error: "Missing required params: #{missing.join(', ')}" }, status: :bad_request
        return
      end

      car = Car.create!(car_params)

      render json: {
        car: {
          id: car.id,
          make: car.make,
          model: car.model,
          year: car.year
        }
      }, status: :created
    end

    private

    def car_params
      params.require(:create_car_params).permit(:id, :make, :model, :year)
    end

    def handle_duplicate_id
      render json: { error: "Car with this id already exists" }, status: :conflict
    end
  end
end
