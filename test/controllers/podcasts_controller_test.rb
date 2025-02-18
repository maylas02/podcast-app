require "test_helper"

class PodcastsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get podcasts_search_url
    assert_response :success
  end
end
