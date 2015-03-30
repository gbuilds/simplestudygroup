class AttendancesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @event = Event.find(params[:attendance][:event_id])
    event_id = @event.id
    user_id = current_user.id
    if Attendance.where({user_id: user_id, event_id: event_id}).blank?
      @attendance = Attendance.new(user_id: user_id, event_id: event_id)
      if @attendance.save
        flash[:success] = "You are registered"
        redirect_to event_path(@event)
      else
        flash[:danger] = "Registration failed"
        redirect_to event_path(@event)
      end
    else
      flash[:warning] = "You are already registered for this event"
      redirect_to event_path(@event)
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @attendance = @event.attendances.where(user_id: current_user.id).first
    @attendance.destroy if @attendance
    flash[:success] = "You are no longer attending this event"
    redirect_to event_path(@event)
  end
  
  private
  
  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
  
end
