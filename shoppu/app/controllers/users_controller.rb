class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

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
      render 'edit'
    end
  end



 private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :address, :email,:password,  :password_confirmation, :birthdate,
    :first_name, :last_name, :is_moderator, :rating => "0", :failed_login_attempts => "0")
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
