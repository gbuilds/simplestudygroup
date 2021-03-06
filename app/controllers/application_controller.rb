class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  around_filter :user_time_zone, if: :current_user
  
  def current_city
    current_user.city
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :description, :city_id, :tag_list) }
  end
  
  def user_time_zone(&block)
    Time.use_zone(current_city.time_zone, &block)
  end
end
