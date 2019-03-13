class Pages::RoomController < ApplicationController
  def index
    if (params[:new_message] != "") && (params[:new_message] != nil)
      params[:chat_messages] = "#{params[:chat_messages]}\n#{params[:new_message]}"
    end

    if (params[:command] != "") && (params[:command] != nil)
      
    end
  end
end
