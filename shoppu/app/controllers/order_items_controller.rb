class OrderItemsController < ApplicationController
  before_action :set_order

  def new
  end

  def show
  end

  def create
    @order_item = @order.order_items_create(order_item_params)
    redirect_to @order
  end

  def update
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def order_item_params
    params[:order_item].permit(:status, :content)
  end

end
