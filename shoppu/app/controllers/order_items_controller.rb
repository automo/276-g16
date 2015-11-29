class OrderItemsController < ApplicationController
  # before_action :set_order_request
  before_action :logged_in_user #, only: [:create, :destroy]

  before_action except: [:complete] do
    set_order_request("owner")
    # set_order_item #("owner")
  end

  before_action only: [:complete] do
    set_order_request("servicer")
    # set_order_item #("servicer")
  end

  before_action :set_order_item

  before_action :correct_user, except: [:create]


  # before_action only: [:destroy] do
  #   correct_user("owner")
  # end
  #
  # before_action only: [:complete] do
  #   correct_user("servicer")
  # end
  # before_action :debug
  #
  # def debug
  #   render :text => @order_request.inspect
  # end

  # def show
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
  			flash[:error] = "Order item could not be deleted. [0x0204]"
  		end
    end
		redirect_to @order_request
	end

  def complete
		if !@order_item.update_attribute(:completed_at, Time.now)
      flash[:error] = "Failed to complete item - Please try again [0x0203]"
    end

		redirect_to order_requests_show_one_accepted_path(:id => @order_request.id), notice: "Order item completed"
	end

  private

  def set_order_request(user_type)
    if (user_type == "owner")
      @order_request = current_user.owned_orders.find_by_id(params[:order_request_id])
    elsif (user_type == "servicer")
      @order_request = current_user.serviced_orders.find_by_id(params[:order_request_id])
    else # force method to fail
      @order_request = nil
    end

    if @order_request.nil?
      flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0200]"
      redirect_to root_url
    end
  end

  def set_order_item
    @order_item = @order_request.order_items.find_by_id(params[:id])
  end

  def correct_user
    if (@order_request.blank? || @order_item.blank?)
      flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0201]"
      redirect_to root_url
    end
  end

  def order_item_params
    params[:order_item].permit(:content)
  end
end
