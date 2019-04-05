class Pages::LoginController < ApplicationController
  @loginMessage = ""
  # This is used for UI Test
  # def index
  #   if (params[:user_name] == "sss") && (params[:user_pass] == "sss")
  #     redirect_to :controller => 'pages/home', :action => "index", :format => 'html'
  #   else
  #   end
  # end

  # This is used for Database Test
  def index
    if params[:user_name] == "" || params[:user_pass] == ""
      @loginMessage = "Please Enter username nad password."
    else
      user = User.where("user_name = ? AND user_pass = ?", params[:user_name], params[:user_pass])[0]
      puts "!!!!!!!!!!#{user}!!!!!!!!!!!!!!!!"
      if "#{user}" == ""
        @loginMessage = "There is no matching user."
      else
        redirect_to :controller => 'pages/home', :action => "index", :format => 'html', :user_name => params[:user_name]
      end
    end

  end
end
