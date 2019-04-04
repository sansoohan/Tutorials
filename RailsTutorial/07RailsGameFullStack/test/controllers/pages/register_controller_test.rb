require 'test_helper'

class Pages::RegisterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_register_index_url
    assert_response :success
  end

end
