require "test_helper"

class Api::CarsControllerTest < ActionDispatch::IntegrationTest
  test "should create a car and return 201 with car details" do
    car_id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"

    post "/api/cars", params: {
      create_car_params: {
        id: car_id,
        make: "Toyota",
        model: "Legacy",
        year: "2015"
      }
    }, as: :json

    assert_response :created
    response_json = JSON.parse(response.body)
    assert_equal car_id, response_json["car"]["id"]
    assert_equal "Toyota", response_json["car"]["make"]
    assert_equal "Legacy", response_json["car"]["model"]
    assert_equal 2015, response_json["car"]["year"]
  end

  test "should return 400 when create_car_params is missing" do
    post "/api/cars", params: {}, as: :json

    assert_response :bad_request
    response_json = JSON.parse(response.body)
    assert response_json["error"].present?
  end

  test "should return 400 when id is missing" do
    post "/api/cars", params: {
      create_car_params: {
        make: "Toyota",
        model: "Legacy",
        year: "2015"
      }
    }, as: :json

    assert_response :bad_request
    response_json = JSON.parse(response.body)
    assert response_json["error"].present?
  end

  test "should return 400 when make is missing" do
    post "/api/cars", params: {
      create_car_params: {
        id: "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        model: "Legacy",
        year: "2015"
      }
    }, as: :json

    assert_response :bad_request
    response_json = JSON.parse(response.body)
    assert response_json["error"].present?
  end

  test "should return 400 when model is missing" do
    post "/api/cars", params: {
      create_car_params: {
        id: "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        make: "Toyota",
        year: "2015"
      }
    }, as: :json

    assert_response :bad_request
    response_json = JSON.parse(response.body)
    assert response_json["error"].present?
  end

  test "should return 400 when year is missing" do
    post "/api/cars", params: {
      create_car_params: {
        id: "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        make: "Toyota",
        model: "Legacy"
      }
    }, as: :json

    assert_response :bad_request
    response_json = JSON.parse(response.body)
    assert response_json["error"].present?
  end
end
