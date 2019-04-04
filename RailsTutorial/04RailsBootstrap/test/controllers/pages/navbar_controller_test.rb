require 'test_helper'

class Pages::NavbarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_navbar_index_url
    assert_response :success
  end

end
