require 'test_helper'

class Pages::LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_login_index_url
    assert_response :success
  end

end
