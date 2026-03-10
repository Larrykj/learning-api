require "test_helper"

module Api
  class CarsControllerTest < ActionDispatch::IntegrationTest
    test "creates car successfully with all required params" do
      post "/api/cars", params: {
        create_car_params: {
          id: "550e8400-e29b-41d4-a716-446655440000",
          make: "Toyota",
          model: "Legacy",
          year: "2015"
        }
      }, as: :json

      assert_response :created
      response_data = JSON.parse(response.body)
      assert_equal "550e8400-e29b-41d4-a716-446655440000", response_data["car"]["id"]
      assert_equal "Toyota", response_data["car"]["make"]
      assert_equal "Legacy", response_data["car"]["model"]
      assert_equal "2015", response_data["car"]["year"]
    end

    test "returns 400 when id is missing" do
      post "/api/cars", params: {
        create_car_params: {
          make: "Toyota",
          model: "Legacy",
          year: "2015"
        }
      }, as: :json

      assert_response :bad_request
      response_data = JSON.parse(response.body)
      assert response_data["error"].include?("id")
    end

    test "returns 400 when make is missing" do
      post "/api/cars", params: {
        create_car_params: {
          id: "550e8400-e29b-41d4-a716-446655440000",
          model: "Legacy",
          year: "2015"
        }
      }, as: :json

      assert_response :bad_request
      response_data = JSON.parse(response.body)
      assert response_data["error"].include?("make")
    end

    test "returns 400 when model is missing" do
      post "/api/cars", params: {
        create_car_params: {
          id: "550e8400-e29b-41d4-a716-446655440000",
          make: "Toyota",
          year: "2015"
        }
      }, as: :json

      assert_response :bad_request
      response_data = JSON.parse(response.body)
      assert response_data["error"].include?("model")
    end

    test "returns 400 when year is missing" do
      post "/api/cars", params: {
        create_car_params: {
          id: "550e8400-e29b-41d4-a716-446655440000",
          make: "Toyota",
          model: "Legacy"
        }
      }, as: :json

      assert_response :bad_request
      response_data = JSON.parse(response.body)
      assert response_data["error"].include?("year")
    end

    test "returns 409 when car id already exists" do
      # Create first car
      post "/api/cars", params: {
        create_car_params: {
          id: "550e8400-e29b-41d4-a716-446655440000",
          make: "Toyota",
          model: "Legacy",
          year: "2015"
        }
      }, as: :json

      assert_response :created

      # Attempt to create car with same id
      post "/api/cars", params: {
        create_car_params: {
          id: "550e8400-e29b-41d4-a716-446655440000",
          make: "Honda",
          model: "Civic",
          year: "2020"
        }
      }, as: :json

      assert_response :conflict
      response_data = JSON.parse(response.body)
      assert_equal "Car with this id already exists", response_data["error"]
    end

    test "returns 400 when make is blank" do
      post "/api/cars", params: {
        create_car_params: {
          id: "550e8400-e29b-41d4-a716-446655440000",
          make: "",
          model: "Legacy",
          year: "2015"
        }
      }, as: :json

      assert_response :bad_request
      response_data = JSON.parse(response.body)
      assert response_data["error"].include?("make")
    end
  end
end
