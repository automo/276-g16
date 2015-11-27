require 'test_helper'

class OrderRequestsControllerTest < ActionController::TestCase
  setup do
    @user = users(:UserTwo)
    log_in_as(@user)
    @order_request = @user.owned_orders.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_request" do
    # puts @order_request.inspect
    assert_difference('OrderRequest.count') do
      post :create, order_request: { accepted_at: "2015-11-08 00:09:31", bounty: "123", description: "test description", owner_id: "1", title: "hello world!" }
    end

    assert_redirected_to order_request_path(assigns(:order_request))
  end

  test "should show order_request" do
    get :show, id: @order_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_request
    assert_response :success
  end

  test "should update order_request" do
    patch :update, id: @order_request, order_request: { accepted_at: @order_request.accepted_at, bounty: @order_request.bounty, deliver_by: @order_request.deliver_by, description: @order_request.description, owner_id: @order_request.owner_id, service_rating: @order_request.service_rating, servicer_id: @order_request.servicer_id, status: @order_request.status, title: @order_request.title }
    assert_redirected_to order_request_path(assigns(:order_request))
  end

  test "should destroy order_request" do
    assert_difference('OrderRequest.count', -1) do
      delete :destroy, id: @order_request
    end
    assert_redirected_to order_requests_path
  end
end
