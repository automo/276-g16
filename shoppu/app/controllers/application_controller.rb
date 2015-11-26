class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_order_request
    # @order_request = current_user.order_requests.find_by(params[:id])
    # @order_request = OrderRequest.find(params[:id])
    @order_request = current_user.owned_orders.find_by_id(params[:id])
    # @order_request = current_user.owned_orders.find_by_id(params[:order_request_id])
    if @order_request.nil?
      flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0100]"
      redirect_to root_url
    end
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      # store_location
      flash[:danger] = "Please log in."
      redirect_to root_url
    end
  end
end
