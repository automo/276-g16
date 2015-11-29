require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should redirect create when not logged in" do
  assert_no_difference 'session.count' do
    post :create
  end
  assert_redirected_to login_url
end

test "should redirect destroy when not logged in" do
  assert_no_difference 'session.count' do
    delete :destroy, id: users(:UserOne)
  end
  assert_redirected_to login_url
end



end
