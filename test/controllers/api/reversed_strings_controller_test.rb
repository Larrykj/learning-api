require "test_helper"

class Api::ReversedStringsControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  test "should return reversed string" do
    get "/api/process_string", params: { input_string: "Hello" }
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "Hello", json_response["original"]
    assert_equal "olleH", json_response["reversed_string"]
  end

  test "should handle empty string" do
    get "/api/process_string", params: { input_string: "" }
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "", json_response["original"]
    assert_equal "", json_response["reversed_string"]
  end
=======
  # test "the truth" do
  #   assert true
  # end
>>>>>>> 1bd5bc9 (Reversal of string Hello into olleH)
end
