class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @city = current_user.city
    end
  end
end
