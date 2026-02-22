require "test_helper"

class Api::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should return title from query param" do
    get api_book_title_url(title: "Ruby")

    assert_response :success
    response_json = JSON.parse(response.body)
    assert_equal "Ruby", response_json["title"]
  end

  test "should return empty title when missing" do
    get api_book_title_url

    assert_response :success
    response_json = JSON.parse(response.body)
    assert_equal "", response_json["title"]
  end
end
