require "test_helper"

module Api
  class ChangesControllerTest < ActionDispatch::IntegrationTest
    test "should get check endpoint with even number" do
      get api_check_url(changes: 4)
      assert_response :success
      response_json = JSON.parse(response.body)
      assert_equal 4, response_json["number"]
      assert_equal "even", response_json["status"]
      assert_equal true, response_json["is_even"]
    end

    test "should get check endpoint with odd number" do
      get api_check_url(changes: 7)
      assert_response :success
      response_json = JSON.parse(response.body)
      assert_equal 7, response_json["number"]
      assert_equal "odd", response_json["status"]
      assert_equal false, response_json["is_even"]
    end

    test "should get check endpoint with zero" do
      get api_check_url(changes: 0)
      assert_response :success
      response_json = JSON.parse(response.body)
      assert_equal 0, response_json["number"]
      assert_equal "even", response_json["status"]
      assert_equal true, response_json["is_even"]
    end

    test "should handle invalid input gracefully" do
      get api_check_url(changes: "abc")
      assert_response :success
      response_json = JSON.parse(response.body)
      assert_equal 0, response_json["number"]
      assert_equal "even", response_json["status"]
    end
  end
end
