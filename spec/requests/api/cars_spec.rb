require "rails_helper"

RSpec.describe "Api::Cars", type: :request do
  describe "POST /api/cars" do
    let(:valid_params) do
      {
        create_car_params: {
          id: "550e8400-e29b-41d4-a716-446655440000",
          make: "Toyota",
          model: "Legacy",
          year: "2015"
        }
      }
    end

    it "creates a car and returns 201" do
      post "/api/cars", params: valid_params, as: :json

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq(
        "car" => {
          "id" => "550e8400-e29b-41d4-a716-446655440000",
          "make" => "Toyota",
          "model" => "Legacy",
          "year" => "2015"
        }
      )
    end

    it "returns 400 when create_car_params is missing" do
      post "/api/cars", params: {}, as: :json

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq(
        "error" => "Missing required param: create_car_params"
      )
    end

    it "returns 400 when a required field is missing" do
      post "/api/cars", params: {
        create_car_params: {
          id: "550e8400-e29b-41d4-a716-446655440000",
          make: "Toyota",
          year: "2015"
        }
      }, as: :json

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq(
        "error" => "Missing required params: model"
      )
    end

    it "returns 409 when the car id already exists" do
      post "/api/cars", params: valid_params, as: :json
      post "/api/cars", params: valid_params, as: :json

      expect(response).to have_http_status(:conflict)
      expect(JSON.parse(response.body)).to eq(
        "error" => "Car with this id already exists"
      )
    end
  end
end
