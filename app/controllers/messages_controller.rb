class MessagesController < ApplicationController

    def index; end
    
    def create
      @partner = params[:id].to_i
      @user = current_user

      ActionCable.server.broadcast("room #{params[:room]}", { text: parse_text(params[:text]), sender: @user.name, receiver: @partner })
    end

    def parse_text(text)
      text.gsub(/(<([^>]+)>)/,"")
    end
    
end


