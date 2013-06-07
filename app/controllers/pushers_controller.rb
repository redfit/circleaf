class PushersController < ApplicationController
  protect_from_forgery except: :authentication
  
  def authentication
    res = Pusher[params[:channel_name]].authenticate(
      params[:socket_id],
      user_id: current_user.id,
      user_info: current_user
    )
    render json: res
  end
end
