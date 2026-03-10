module Api
  class CarsController < ApplicationController
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

      car = Car.new(car_params)

      if car.save
        render json: {
          car: {
            id: car.id,
            make: car.make,
            model: car.model,
            year: car.year
          }
        }, status: :created
      else
        render json: { error: car.errors.full_messages }, status: :bad_request
      end
    end

    private

    def car_params
      params.require(:create_car_params).permit(:id, :make, :model, :year)
    end
  end
end
