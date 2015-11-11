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
    assert_template 'users/edit'
    patch user_path(@user), user: { username:  "username1",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end


  test "successful edit" do


    log_in_as(@user)

    get edit_user_path(@user)
    assert_template 'users/edit'
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
