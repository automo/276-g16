module UsersHelper
  def getOpenCount(user_id)
    order_requests = User.find(user_id).owned_orders.all
    return order_requests.select{|order_request| order_request.status != "open"}.size
  end

  def getAcceptedCount(user_id)
    order_requests = User.find(user_id).owned_orders.all
    return order_requests.select{|order_request| order_request.status != "accepted"}.size
  end

  def getCompletedCount(user_id)
    order_requests = User.find(user_id).owned_orders.all
    return order_requests.select{|order_request| order_request.status != "completed"}.size
  end

  def getHiddenCount(user_id)
    order_requests = User.find(user_id).owned_orders.all
    return order_requests.select{|order_request| order_request.status != "hidden"}.size
  end
end
