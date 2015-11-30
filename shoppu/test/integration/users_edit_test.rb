require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:UserOne)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    # assert_template layout: "layouts/application", partial: "_head"
    # assert_template layout: "layouts/application", partial: "_body"
    # assert_template layout: "layouts/application", partial: "_footer"
    assert_template 'users/edit'
    patch user_path(@user), user: { username:  "",
                                    email: "foo@invalid",
                                    password: "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end


  test "successful edit, smart forwarding and lowercase username conversion" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    new_username  = "Test Name"
    new_email = "hello@example.com"
    patch user_path(@user), user: { username: new_username,
                                    email: new_email,
                                    password: "",
                                    password_confirmation: "" }
    #assert_not flash.empty?
    #assert_redirected_to @user
    @user.reload
    assert_equal new_username.downcase, @user.username
    assert_equal new_email, @user.email
  end
end
