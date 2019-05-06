require 'test_helper'

class Pages::AboutControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_about_index_url
    assert_response :success
  end

end
