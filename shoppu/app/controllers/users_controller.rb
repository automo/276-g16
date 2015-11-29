class UsersController < ApplicationController
  before_action :set_user, except: [:reset_accepted_orders, :new, :create]
  before_action :logged_in_user, except: [:reset_accepted_orders, :show, :new, :create]
  before_action :correct_user, except: [:reset_accepted_orders, :new, :create]

  def show
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
