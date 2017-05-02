require 'test_helper'

class CommunityControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get community_edit_url
    assert_response :success
  end

  test "should get create" do
    get community_create_url
    assert_response :success
  end

  test "should get update" do
    get community_update_url
    assert_response :success
  end

  test "should get destroy" do
    get community_destroy_url
    assert_response :success
  end

end
