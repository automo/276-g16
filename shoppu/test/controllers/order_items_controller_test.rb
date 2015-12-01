require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:UserTwo)
    log_in_as(@user)
    @order_request = @user.owned_orders.first
    @order_item = @order_request.order_items.first
  end

  test "should create order_item" do
    assert_difference('OrderItem.count') do
      post :create, order_item: {content: 'Hi'}
    end
    assert_redirected_to order_request_path
    assert_equal 'Order item was added.', flash[:success]
  end

  test "should destroy order_item" do
    assert_difference('OrderItem.count',-1) do
      delete :destroy, id: @order_item
    end
    assert_redirected_to order_request_path
    assert_equal 'Order item was deleted.', flash[:success]
  end


end
