class EventsController < ApplicationController
  
  def new
    @event = current_user.created_events.build
  end
  
  def create
    @event = current_user.created_events.build(event_params)
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  private
  
  def event_params
  end
  
end
