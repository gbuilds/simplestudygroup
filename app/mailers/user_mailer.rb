class UserMailer < ApplicationMailer
  default from: "notifications@getstudygroup.com"
  
  def welcome_email(user)
    @user = user
    @url = 'https://getstudygroup.herokuapp.com'
    mail(to: @user.email, subject: "Welcome to Studygroup")
  end
end
