class RegistrationsController < Devise::RegistrationsController

  def create
    super
    UserMailer.welcome_email(@user).deliver_now if @user.errors.empty? && @user.persisted?
    processor = SignupProcessor.new(@user)
    processor.create_friendship_requests
  end

end