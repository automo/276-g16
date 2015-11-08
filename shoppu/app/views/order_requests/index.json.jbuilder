json.array!(@order_requests) do |order_request|
  json.extract! order_request, :id, :title, :bounty, :deliver_by, :accepted_at, :service_rating, :status, :owner_id, :servicer_id, :description
  json.url order_request_url(order_request, format: :json)
end
