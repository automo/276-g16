

class UserMailer < ApplicationMailer
  default from: 'shoppumail@gmail.com'

  def user_email(user)
   @user = user

   mail(to: @user.email, subject: 'Welcome to Shoppu')
 end

end
