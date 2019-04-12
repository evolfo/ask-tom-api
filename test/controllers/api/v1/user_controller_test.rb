require 'test_helper'

class Api::V1::UserControllerTest < ActionDispatch::IntegrationTest
  test "should get name" do
    get api_v1_user_name_url
    assert_response :success
  end

end
