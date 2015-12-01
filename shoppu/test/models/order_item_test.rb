require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(username: "Example User", email: "user@example.com",address:"sfu", is_moderator:"true",first_name:"asd",last_name:"sada",password:"123456",password_confirmation:"123456",birthdate:"2012-11-11", id:"1")
    @order_request = @user.owned_orders.build(title: "Example Title", bounty: "123.99", address: "1234 123St, XY, A1A 1A1 Canada")
    @order_item = @order_request.order_items.build(content: "Example item")
  end

  test "order_item should be valid" do
    assert @order_item.valid?
  end

end
