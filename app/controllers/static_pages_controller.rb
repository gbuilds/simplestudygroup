class StaticPagesController < DeviseController
  # Inherits from DeviseController to access resouce class method for min password length
  # https://github.com/plataformatec/devise/blob/v3.4.1/app/controllers/devise/registrations_controller.rb
  
  def home
    if user_signed_in?
      @city = current_user.city
      @feed_items = current_user.feed
      @invitation = Invitation.new
    else
      @minimum_password_length = resource_class.password_length.min
      @user = User.new
    end
  end
end
