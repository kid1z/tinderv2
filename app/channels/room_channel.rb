class RoomChannel < ApplicationCable::Channel
  def subscribed
    puts params
    stream_from "room #{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  
end
