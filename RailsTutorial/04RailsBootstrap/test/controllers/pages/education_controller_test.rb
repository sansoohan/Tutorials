require 'test_helper'

class Pages::EducationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_education_index_url
    assert_response :success
  end

end
