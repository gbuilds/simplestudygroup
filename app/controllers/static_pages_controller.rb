class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @city = current_user.city
      @feed_items = current_user.feed
    end
  end
end
