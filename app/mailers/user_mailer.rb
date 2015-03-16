class UserMailer < ApplicationMailer
  default from: "notifications@studygroup.io"
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Studygroup")
  end
end
