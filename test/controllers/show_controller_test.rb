require "test_helper"

class ShowControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get show_show_url
    assert_response :success
  end

  test "should get set_show" do
    get show_set_show_url
    assert_response :success
  end
end
