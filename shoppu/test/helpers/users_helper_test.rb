require 'test_helper'

class UsersHelperTest < ActionView::TestCase

  def setup
    @user = users(:UserOne)
    log_in_as(@user)
    @order_request = order_requests(:test_list)
  end


  test"count all order by status" do


  end
end
