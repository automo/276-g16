class OrderItemsController < ApplicationController
  before_action :set_order_request
  before_action :set_order_item, except: [:create]
  before_action :logged_in_user, only: [:create, :destroy]
  # before_action :debug
  #
  # def debug
  #   render :text => @order_request.inspect
  # end

  # def show
  #   redirect_to @order_request
  # end

  def create
    # @order_request = current_user.owned_orders.find_by(id: params[:id])
		@order_item = @order_request.order_items.create(order_item_params)
		redirect_to @order_request
	end

  def destroy
    if @order_item.present?
  		if @order_item.destroy
  			flash[:success] = "Order item was deleted."
  		else
  			flash[:error] = "Order item could not be deleted."
  		end
    end
		redirect_to @order_request
	end

  def complete
		@order_item.update_attribute(:completed_at, Time.now)
		redirect_to @order_request, notice: "Order item completed"
	end

  private

  def set_order_request
    # @order_request = OrderRequest.find(params[:order_request_id])
    @order_request = current_user.owned_orders.find(params[:order_request_id])
    # @order_request = current_user.owned_orders.find_by(owner_id: params[:id])
    if @order_request.nil?
      flash[:error] = "A processing error has occurred - Sorry for the inconvenience"
      redirect_to root_url
    end
  end

  def set_order_item
    @order_item = @order_request.order_items.find(params[:id])
  end

  def order_item_params
    params[:order_item].permit(:content)
  end
end
