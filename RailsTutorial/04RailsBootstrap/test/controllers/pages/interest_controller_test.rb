require 'test_helper'

class Pages::InterestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_interest_index_url
    assert_response :success
  end

end
