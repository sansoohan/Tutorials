class Pages::RoomController < ApplicationController
  def index
    if (params[:new_message] != "") && (params[:new_message] != nil)
      params[:chat_messages] = "#{params[:chat_messages]}\n#{params[:new_message]}"
    end

    if (params[:command] != "") && (params[:command] != nil)
      command_array = params[:command].split(/ /)
      case command_array[0]
      when "/attack"
        attack(command_array[1].to_i, command_array[2].to_i)
      when "/ready"
        ready
      when "/start"
        start
      when "/leave"
        leave
      end
    end
  end

  def attack(row, col)
  end

  def ready
  end

  def start
  end

  def leave
  end
end
