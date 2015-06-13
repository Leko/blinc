require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get term" do
    get :term
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

end
