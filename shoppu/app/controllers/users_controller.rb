class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
   @user = User.new(user_params)

   if @user.save
     log_in @user
     UserMailer.user_email(@user).deliver
      flash[:success] = "Welcome to the Shoppu App!"

     redirect_to @user
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
