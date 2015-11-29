class UsersController < ApplicationController
  # before_action :set_order_request, only: [:accept_order_request]
  before_action :set_user, except: [:reset_accepted_orders, :new, :create]
  before_action :logged_in_user, except: [:reset_accepted_orders, :show, :new, :create]
  before_action :correct_user, except: [:reset_accepted_orders, :new, :create]
  # after_initialize :init
  #
  # def init
  #   self.rating  ||= 0
  #   self.failed_login_attempts ||= 0
  # end

  # # DELETE BEFORE SUBMISSION
  # def reset_accepted_orders
  #   OrderRequest.all.each do |order_request|
  #     order_request.update_attributes(:servicer_id => nil, :status => "open")
  #   end
  #   render('accepted_order_requests')
  # end

  # def accept_order_request
  #   @order_request = OrderRequest.find_by_id(params[:order_request_id])
  #   if @order_request.blank?
  #     flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0000]"
  #     redirect_to @user
  #   end
  #
  #   if !@order_request.update_attributes(:servicer_id => current_user.id, :status => "accepted")
  #     flash[:error] = "Failed to accept order - Please try again"
  #     redirect_to @user
  #   end
  #
  #   accepted_order_requests
  #   render('accepted_order_requests')
  #
  # end

  # def accepted_order_requests
  #   # Selects order requests which are serviced by current_user
  #   @order_requests = OrderRequest.select { |order_request| \
  #                         # order_request.status == "accepted" && \
  #                         order_request.servicer_id == current_user.id}
  #
  #   # if @order_requests.blank?
  #   #   flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0000]"
  #   #   redirect_to root_url
  #   # end
  # end

  # def open_order_requests
  #   # Selects open order_requests which have a positive number of order_items
  #   #  AND which belong to other users
  #   @order_requests = OrderRequest.select { |order_request| \
  #                     order_request.status == "open" && \
  #                     order_request.order_items.all.size > 0 && \
  #                     order_request.owner_id != current_user.id}
  #
  #   # if @order_requests.blank?
  #   #   flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0000]"
  #   #   redirect_to root_url
  #   # end
  #   # render('open_order_requests')
  # end

  def show
    # @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
   @user = User.new(user_params)

   if @user.save
    log_in @user

    flash[:success] = "Welcome to the Shoppu App!"

    redirect_to user_path(current_user.id)
    UserMailer.user_email(@user).deliver
   else
     flash[:error] = "Failed to create account - Please try again [0x0002]"
     render 'new'
   end
 end

# Adding new action for update user profile
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:error] = "Failed to update information - Please try again [0x0003]"
      render 'edit'
    end
  end

 private

  def set_user
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0000]"
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit(:username, :address, :email, :password, :password_confirmation, :birthdate, :first_name, :last_name, :is_moderator)
  end

  def correct_user
    # @user = User.find_by_id(params[:id])
    # redirect_to(root_url) unless current_user?(@user)
    if !current_user?(@user)
      flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0001]"
      redirect_to root_url
    end
  end
end
