class OrderRequestsController < ApplicationController
  layout 'order_request.html.erb' # ~K
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_order_request, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :update, :destroy]

  # def accept_order_request
  #   if @order_request.update_attributes(:servicer_id => current_user.id)
  #     flash[:success] = "Order successfully accepted"
  #   else
  #     flash[:error] = "Failed to accept order - Please try again"
  #   end
  #   redirect_to @user
  # end

  # GET /order_requests
  # GET /order_requests.json
  def index
    @order_requests = OrderRequest.all
  end

  # GET /order_requests/1
  # GET /order_requests/1.json
  def show
    # redirect_to root_url
  end

  # GET /order_requests/new
  def new
    @order_request = current_user.owned_orders.build
  end

  # GET /order_requests/1/edit
  def edit
  end

  # POST /order_requests
  # POST /order_requests.json
  def create
    # puts @current_user
    @order_request = current_user.owned_orders.build(order_request_params)
    # @user = User.find(params[:id])
    # @order_request = @user.order_requests.build

    respond_to do |format|
      if @order_request.save
        format.html { redirect_to @order_request, notice: 'Order request was successfully created.' }
        format.json { render :show, status: :created, location: @order_request }
      else
        format.html { render :new }
        format.json { render json: @order_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_requests/1
  # PATCH/PUT /order_requests/1.json
  def update
    respond_to do |format|
      if @order_request.update_attributes(order_request_params)
        format.html { redirect_to @order_request, notice: 'Order request was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_request }
      else
        format.html { render :edit }
        format.json { render json: @order_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_requests/1
  # DELETE /order_requests/1.json
  def destroy
    @order_request.destroy
    respond_to do |format|
      format.html { redirect_to order_requests_url, notice: 'Order request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    def correct_user
      # @order_request = current_user.order_requests.find_by_id(params[:id])
      if (@order_request == false)
        flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0101]"
        redirect_to root_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_request_params
      # params.require(:order_request).permit(:title, :bounty, :deliver_by, :accepted_at, :service_rating, :status, :owner_id, :servicer_id, :description)
      params.require(:order_request).permit(:title, :bounty, :deliver_by, :accepted_at, :service_rating, :status, :description)
    end

    # def accept_order_request_params
    #   params.require(:order_request).permit(:title, :bounty, :deliver_by, :accepted_at, :service_rating, :status => "accepted", :description, :servicer_id => current_user.id)
    # end
end
