require "test_helper"

class SystemControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get system_register_url
    assert_response :success
  end

  test "should get feed" do
    get system_feed_url
    assert_response :success
  end

  test "should get new_post" do
    get system_new_post_url
    assert_response :success
  end

  test "should get profile" do
    get system_profile_url
    assert_response :success
  end
end
