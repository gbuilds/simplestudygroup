class AttendancesController < ApplicationController
  
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
      flash[:danger] = "You are already registered for this event"
      redirect_to event_path(@event)
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @attendance = @event.attendances.where(user_id: current_user.id).first
    @attendance.destroy
    flash[:success] = "Deleted your attendance"
    redirect_to event_path(@event)
  end
  
end
