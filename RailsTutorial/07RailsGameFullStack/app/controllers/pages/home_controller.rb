class Pages::HomeController < ApplicationController
  @command
  def index
    if params[:command]
      @command = params[:command].rstrip.split(/ /)
      case @command[0]
      when "/make"
        make
      when "/join"
        join
      end
    end
  end
  def make
    puts "!!!!!!!!!!!!!!!!! make #{@command[1]}"
  end
  def join
    puts "!!!!!!!!!!!!!!!!! join #{@command[1]}"
  end
end
