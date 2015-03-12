class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :user_is_creator, only: [:edit, :update, :destroy]
  
  def new
    @event = current_user.created_events.build
  end
  
  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      current_user.register @event
      redirect_to event_path(@event)
    else
      flash[:danger] = "Something went wrong"
      render 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event successfully updated"
      redirect_to @event
    else
      flash[:danger].now = "Event failed to save"
      render 'edit'
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
  
  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:notice] = "Event was deleted successfully."
      redirect_to events_path
    else
      render 'show'
      flash.now[:danger] = "Something went wrong"
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
    unless event.creator == current_user
      redirect_to event
      flash[:danger] = "You need to be the event's creator to edit"
    end
  end
end
