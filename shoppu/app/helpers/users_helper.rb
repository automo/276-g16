module UsersHelper
  # Note: recognized status_types are "accepted", "hidden", "open", "completed"
  def count_orders_by_status(user_id, status_type)
    order_requests = User.find_by_id(user_id).owned_orders.all
    return 0 if order_requests.blank?
    return order_requests.select{|order_request| order_request.status == status_type}.size
  end

  # Note: recognized status_types are "accepted", "hidden", "open", "completed"
  def count_all_orders_by_status(status_type)
    order_requests = OrderRequest.all
    return 0 if order_requests.blank?
    return order_requests.select{|order_request| order_request.status == status_type}.size
  end

  def count_all_orders
    return OrderRequest.all.size
  end
end
