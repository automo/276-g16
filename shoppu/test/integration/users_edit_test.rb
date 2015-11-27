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
    # assert_template 'users/edit'
    assert_template layout: "layouts/application", partial: "_auth"
    patch user_path(@user), user: { username:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end


  test "successful edit" do
    get edit_user_path(@user)
    log_in_as(@user)
    # get edit_user_path(@user)
    # assert_template 'users/edit'
    assert_redirected_to edit_user_path(@user)
    name  = "FooBar"
    email = "foo@bar.com"
    patch user_path(@user), user: { username:  name,
                                    email: email,
                                   }
    #assert_not flash.empty?
    #assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
