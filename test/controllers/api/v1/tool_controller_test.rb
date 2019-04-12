require 'test_helper'

class Api::V1::ToolControllerTest < ActionDispatch::IntegrationTest
  test "should get name" do
    get api_v1_tool_name_url
    assert_response :success
  end

  test "should get language" do
    get api_v1_tool_language_url
    assert_response :success
  end

  test "should get difficulty:integer" do
    get api_v1_tool_difficulty:integer_url
    assert_response :success
  end

end
