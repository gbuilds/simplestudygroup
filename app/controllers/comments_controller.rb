class CommentsController < ApplicationController
  
  def create
    @event = Event.find(params[:event_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "You commented successfully"
      redirect_to event_path(@event)
    else
      flash[:danger] = "Your comment failed to post"
      redirect_to event_path(@event)
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body).merge(event_id: params[:event_id])
  end
end
