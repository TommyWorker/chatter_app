require 'test_helper'

class TalksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get talks_index_url
    assert_response :success
  end

end
