require 'test_helper'

class Pages::ExperienceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_experience_index_url
    assert_response :success
  end

end
