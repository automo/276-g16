require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:UserTwo)
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {
                               email: "user@invalid",
                               birthdate: "2013-11-11",
                               address: "sfu",
                               is_moderator: "true",
                               first_name: "",
                               last_name: "",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end

# We dont have action of "activation"
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { email: @user.email,
                               address: @user.address,
                               is_moderator: @user.is_moderator,
                               first_name: @user.first_name,
                               last_name: @user.last_name,
                               birthdate: @user.birthdate,
                               password: "password",
                               password_confirmation: "password" }
    end
    #assert_equal 1, ActionMailer::Base.deliveries.size
    #user = assigns(:user)
    #assert_not user.activated?
    # Try to log in before activation.
    #log_in_as(user)
    #assert_not is_logged_in?
    # Invalid activation token
    #get edit_account_activation_path("invalid token")
    #assert_not is_logged_in?
    #get edit_account_activation_path(user.activation_token, email: 'wrong')
    #assert_not is_logged_in?
    #get edit_account_activation_path(user.activation_token, email: user.email)
    #assert user.reload.activated?
    #follow_redirect!
    assert_template 'users/show'
    #assert is_logged_in?
  end
end
