class EventsController < ApplicationController
  before_action :logged_in_user?
  
  def new
    @event = current_user.created_events.build
  end
  
  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      flash[:danger] = "Something went wrong"
      render 'new'
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def index
    @events = Event.all
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time)
  end
  
  def logged_in_user?
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
end
