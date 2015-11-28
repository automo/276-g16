class OrderRequestsController < ApplicationController
  before_action :logged_in_user #, only: [:create, :destroy]

  before_action only: [:correct_user, :show, :edit, :update, :destroy] do
     set_order_request("from_owner")
  end

  before_action only: [:accept] do
    set_order_request("from_all")
  end

  before_action only: [:show_one_accepted] do
    set_order_request("from_servicer")
  end

  before_action :correct_user, only: [:show, :update, :destroy]

  def show_open
    # Selects open order_requests which have a positive number of order_items
    #  AND which belong to other users
    @order_requests = OrderRequest.select { |order_request| \
                      order_request.status == "open" && \
                      order_request.order_items.all.size > 0 && \
                      order_request.owner_id != current_user.id }

    if @order_requests.nil?
      flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0103]"
      redirect_to root_url
    end
  end

  def show_all_accepted
    set_all_accepted
  end

  def show_one_accepted
    # set_one_accepted
    # set_order_request("servicer")
  end

  # DELETE BEFORE SUBMISSION
  def reset_accepted
    OrderRequest.all.each do |order_request|
      order_request.update_attributes(:servicer_id => nil, :status => "open")
    end
    render('show_all_accepted')
  end

  def accept
    if @order_request.update_attributes(:servicer_id => current_user.id, :status => "accepted")
      set_all_accepted
      render('show_all_accepted')
    else
      flash[:error] = "Failed to accept order - Please try again"
      redirect_to @user
    end
  end

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

    def set_order_request(from_type)
      if from_type == "from_owner"
        @order_request = current_user.owned_orders.find_by_id(params[:id])
      elsif from_type == "from_servicer"
        @order_request = current_user.serviced_orders.find_by_id(params[:id])
      elsif from_type == "from_all"
        @order_request = OrderRequest.find_by_id(params[:id])
      else # force method to fail
        @order_request = nil
      end

      if @order_request.blank?
        flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0100]"
        redirect_to root_url
        return
      end
    end

    def set_all_accepted
      # Selects order requests which are serviced by current_user
      @order_requests = OrderRequest.select { |order_request| \
                            # order_request.status == "accepted" && \
                            order_request.servicer_id == current_user.id}
    end

    # def set_one_accepted
      # @order_request = OrderRequest.select { |order_request| \
      #                   # order_request.status == "accepted" && \
      #                   order_request.id == id && \
      #                   order_request.servicer_id == current_user.id}
    # end

    def correct_user
      # @order_request = current_user.order_requests.find_by_id(params[:id])
      if (@order_request.blank?)
        flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0101]"
        redirect_to root_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_request_params
      # params.require(:order_request).permit(:title, :bounty, :deliver_by, :accepted_at, :service_rating, :status, :owner_id, :servicer_id, :description)
      params.require(:order_request).permit(:title, :bounty, :deliver_by, :accepted_at, :service_rating, :status, :description)
    end
end
