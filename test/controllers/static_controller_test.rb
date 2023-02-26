require "test_helper"

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get static_landing_url
    assert_response :success
  end

  test "should get about" do
    get static_about_url
    assert_response :success
  end

  test "should get contact" do
    get static_contact_url
    assert_response :success
  end
end
