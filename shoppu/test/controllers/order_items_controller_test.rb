require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
  setup do
    @order_item = OrderItem.first
    @order_request = @order_item.order_request
    @user = @order_request.owner
    log_in_as(@user)
  end

  test "should create order_item" do
    assert_difference('OrderItem.count') do
      post :create, order_item: {content: 'Hi'}, order_request_id: @order_request.id
    end
    assert_redirected_to @order_request
    assert_equal 'Order item was added.', flash[:success]
  end

  test "should destroy order_item" do
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: @order_item, order_request_id: @order_request.id
    end
    assert_redirected_to @order_request
    assert_equal 'Order item was deleted.', flash[:success]
  end

end
