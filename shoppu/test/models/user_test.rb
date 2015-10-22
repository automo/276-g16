require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Example User", email: "user@test.com",address:"sfu", is_mod:"true",first_name:"asd",last_name:"sada",password:"123456",password_confirmation:"123456",birthdate:"2012-11-11")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username= "    "
    assert_not @user.valid?
  end

  test "email should be present" do
      @user.email = "     "
      assert_not @user.valid?
  end

  test "email length should be less than 255" do
    @user.email="ad"*200+ "@example.com"
    assert_not @user.valid?
  end

  test "should accept valid mail format" do
  valid_mailadresses = %w[user@test.com USER@test.com test-ds_fs@test.test.org
                       f.l@test.com sd2vf+nico@test.cn]
  valid_mailadresses.each do |valid_mailadresse|
    @user.email = valid_mailadresse
    assert @user.valid?, "#{valid_mailadresse.inspect} should be valid"
  end
end


  test "should reject invalid email format" do
  invalid_mailadresses = %w[user@test,de user_test_test.de user.test@test.
                        user@test_test.de user@test+test.de]
  invalid_mailadresses.each do |invalid_mailadresse|
    @user.email = invalid_mailadresse
    assert_not @user.valid?, "#{invalid_mailadresse} should be invalid"
  end
end




end
