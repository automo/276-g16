class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def new_order_request
    @user = User.find(params[:id])
    @order_request = @user.order_requests.build
  end

  def create_order_request
     @user = User.find(params[:id])
     @order_request = @user.order_requests.build(params[:order_request])
     if @order_request.save
       flash[:notice] = "Your order_request was successfully added."
       redirect_to :action => 'show', :id => @user.id
     else
       render :template => "new_order_request"
     end
   end

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

 private

  def user_params
    params.require(:user).permit(:username, :address, :email,:password,  :password_confirmation, :birthdate,
    :first_name, :last_name, :is_moderator, :rating => "0", :failed_login_attempts => "0")
  end

end
