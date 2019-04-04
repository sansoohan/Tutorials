require 'test_helper'

class Pages::SkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_skills_index_url
    assert_response :success
  end

end
