require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "no mail sent after invalid signup" do
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
    assert_template partial: 'shared/_error_messages'
    assert_template 'users/new', layout: 'layouts/application'
    assert_template 'layouts/_head'
    assert_template 'layouts/_body'
    assert_template 'layouts/_footer'
  end

  test "send mail after valid signup" do
    get signup_path
    post users_path, user: { username: "new_user",
                             email: "new_user@domain.com",
                             address: "SFU Burnaby, BC, Canada",
                             is_moderator: true,
                             first_name: "Rich",
                             last_name: "Shapero",
                             birthdate: "1973-11-11",
                             password: "password123",
                             password_confirmation: "password123" }
    assert_template 'user_mailer/user_email', layout: 'layouts/mailer'
  end
end
