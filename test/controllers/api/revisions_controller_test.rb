require "test_helper"

module Api
  class RevisionsControllerTest < ActionDispatch::IntegrationTest
    test "should calculate even parity" do
      get api_calculate_even_url(calculate_even: 6)

      assert_response :success
      response_json = JSON.parse(response.body)
      assert_equal 6, response_json["number"]
      assert_equal "even", response_json["parity"]
      assert_equal true, response_json["is_even"]
    end

    test "should calculate odd parity" do
      get api_calculate_even_url(calculate_even: 7)

      assert_response :success
      response_json = JSON.parse(response.body)
      assert_equal 7, response_json["number"]
      assert_equal "odd", response_json["parity"]
      assert_equal false, response_json["is_even"]
    end

    test "should handle invalid input as zero" do
      get api_calculate_even_url(calculate_even: "abc")

      assert_response :success
      response_json = JSON.parse(response.body)
      assert_equal 0, response_json["number"]
      assert_equal "even", response_json["parity"]
      assert_equal true, response_json["is_even"]
    end
  end
end