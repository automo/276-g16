require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Example User", address:"sfu", email: "user@example.com", password_digest:"123456",birthdate:"2012-10-1",first_name:"exmaple", last_name:"chan", is_mod:"1",rating:"1",failed_login_attempts:"0")
  end

  test "should be valid" do
    assert @user.invalid?
  end

  test "username should be present" do
    @user. username= "     "
    assert_not @user.valid?
  end

  test "email should be present" do
      @user.email = "     "
      assert_not @user.valid?
    end






end
