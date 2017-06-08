require 'test_helper'

class LoginsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get login_index_url
    assert_response :success
  end

  test "should get login" do
    get login_login_url
    assert_response :success
  end

  test "should get logout" do
    get login_logout_url
    assert_response :success
  end

  test "should get reset_password" do
    get login_reset_password_url
    assert_response :success
  end

end
