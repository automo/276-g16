require 'test_helper'

class OrderRequestTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Example User", email: "user@example.com",address:"sfu", is_moderator:"true",first_name:"asd",last_name:"sada",password:"123456",password_confirmation:"123456",birthdate:"2012-11-11", id:"1")
    @order_request = @user.owned_orders.build(title: "Example Title", bounty: "123.99", owner_id: "1")
    # puts @user.inspect
    # puts @order_request.inspect
  end

  test "order_request should be valid" do
    assert @order_request.valid?
  end

  test "owner id should be present" do
    @order_request.owner_id = nil
    assert_not @order_request.valid?
  end

  test "order should be most recent first" do
    assert_equal order_requests(:most_recent), OrderRequest.first
  end

end
