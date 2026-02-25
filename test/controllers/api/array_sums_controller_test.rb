require "test_helper"

class Api::ArraySumsControllerTest < ActionDispatch::IntegrationTest
  # Verifies correct summation of a valid integer array
  test "should calculate array sum" do
    get api_array_sums_url(array_to_sum: [1, 2, 3, 4, 5])

    assert_response :success
    response_json = JSON.parse(response.body)
    assert_equal [1, 2, 3, 4, 5], response_json["array_to_sum"]
    assert_equal 15, response_json["total"]
  end

  # Verifies non-numeric strings are rejected with a 422 and a descriptive error
  test "should return error for invalid non-numeric values" do
    get api_array_sums_url(array_to_sum: ["4", "abc", "6"])

    assert_response :unprocessable_entity
    response_json = JSON.parse(response.body)
    assert_includes response_json["error"], "abc"
  end

  # Verifies that negative integers are treated as valid
  test "should handle negative integers" do
    get api_array_sums_url(array_to_sum: [-3, 2, -1])

    assert_response :success
    response_json = JSON.parse(response.body)
    assert_equal [-3, 2, -1], response_json["array_to_sum"]
    assert_equal(-2, response_json["total"])
  end
end