class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :user_is_creator [:edit, :update, :destroy]
  
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
    @attendees = @event.attendees.all
    @attendance = Attendance.new
  end
  
  def index
    if params[:tag]
      @events = Event.tagged_with(params[:tag])
    else
      @events = Event.all
    end
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :tag_list).merge(city_id: current_user.city_id)
  end
  
  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
  
  def user_is_creator
    event = Event.find(params[:id])
    redirect_to root_url unless event.creator == current_user
  end
end
