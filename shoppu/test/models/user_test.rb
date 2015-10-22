require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Example User", email: "user@example.com",address:"sfu", is_mod:"true",first_name:"asd",last_name:"sada",password:"123456",password_confirmation:"123456",birthdate:"2012-11-11")
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

  test "accept valid mail format" do
  va_add = %w[user@test.com USER@test.com test-ds_fs@test.dsf.org
                       f.l@test.com sd2vf+nico@test.cn]
  va_add.each do |valid_mailadd|
    @user.email = valid_mailadd
    assert @user.valid?, "#{valid_mailadd.inspect} should be valid"
  end
end


  test "reject invalid email format" do
  inva_add = %w[user@test,sd user_test_test.csf user.test@test.
                        user@test_test.dom user@test+test.dwqd]
  inva_add.each do |invalid_mailadd|
    @user.email = invalid_mailadd
    assert_not @user.valid?, "#{invalid_mailadd} should be invalid"
  end
end




end
