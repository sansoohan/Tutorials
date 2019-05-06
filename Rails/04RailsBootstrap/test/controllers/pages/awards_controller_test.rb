require 'test_helper'

class Pages::AwardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_awards_index_url
    assert_response :success
  end

end
