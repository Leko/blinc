require 'test_helper'

class MovesControllerTest < ActionController::TestCase
  test "should get storylines" do
    get :storylines
    assert_response :success
  end

  test "should get places" do
    get :places
    assert_response :success
  end

  test "should get profiles" do
    get :profiles
    assert_response :success
  end

end
