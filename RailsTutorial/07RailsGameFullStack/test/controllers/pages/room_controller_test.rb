require 'test_helper'

class Pages::RoomControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_room_index_url
    assert_response :success
  end

end
