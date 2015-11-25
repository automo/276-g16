class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  # after_initialize :init
  #
  # def init
  #   self.rating  ||= 0
  #   self.failed_login_attempts ||= 0
  # end
  def open_order_requests
    # Selects open order_requests which have a positive number of order_items
    #  AND which belong to other users
    @all_order_requests = OrderRequest.select { |order_request| \
      order_request.status == "open" && \
      order_request.order_items.all.size > 0 && \
      order_request.owner.id != current_user.id}
    # redirect_to open_order_requests
    render('open_order_requests')
  end

  def show
    # @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  #
  # def create_order_request
  #    @user = User.find(params[:id])
  #    @order_request = @user.order_requests.build(params[:order_request])
  #    if @order_request.save
  #      flash[:notice] = "Your order_request was successfully added."
  #      redirect_to :action => 'show', :id => @user.id
  #    else
  #      render :template => "new_order_request"
  #    end
  #  end

  def create
   @user = User.new(user_params)

   if @user.save
    log_in @user

    flash[:success] = "Welcome to the Shoppu App!"

    redirect_to @user
    UserMailer.user_email(@user).deliver
   else
     render 'new'
   end
 end

# Adding new action for update user profile
  def edit
    # @user=User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.

      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:error] = "Failed to update information - Please try again"
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
    params.require(:user).permit(:username, :address, :email,:password,  :password_confirmation, :birthdate,
    :first_name, :last_name, :rating => "0", :failed_login_attempts => "0")
  end

  def correct_user
    # @user = User.find_by_id(params[:id])
    # redirect_to(root_url) unless current_user?(@user)
    if !current_user?(@user)
      flash[:error] = "A processing error has occurred - Sorry for the inconvenience [0x0001]"
      redirect_to root_url
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
