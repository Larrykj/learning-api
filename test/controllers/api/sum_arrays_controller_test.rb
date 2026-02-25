require "test_helper"

module Api
  class SumArraysControllerTest < ActionDispatch::IntegrationTest
    # Verifies correct summation of a valid integer array
    test "should calculate array sum" do
      get api_calculate_array_sum_url(sum_arrays: [ 1, 2, 3, 4, 5 ])

      assert_response :success
      response_json = JSON.parse(response.body)
      assert_equal [ 1, 2, 3, 4, 5 ], response_json["sum_arrays"]
      assert_equal 15, response_json["total"]
    end

    # Verifies non-numeric strings are coerced to 0 via to_i
    test "should handle invalid values as zero" do
      get api_calculate_array_sum_url(sum_arrays: [ "4", "abc", "6" ])

      assert_response :success
      response_json = JSON.parse(response.body)
      assert_equal [ 4, 0, 6 ], response_json["sum_arrays"]
      assert_equal 10, response_json["total"]
    end
  end
end
