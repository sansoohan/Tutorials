class Pages::RegisterController < ApplicationController
  def index
    if params.has_key?(:user_name)
      @registerMessage  = ""
      if (params[:user_name] == "") || (params[:user_pass] == "") || (params[:user_confirm] == "") || (params[:user_email] == "")
        @registerMessage  = "Please Fill The Form."
        return
      end

      if params[:user_pass] != params[:user_confirm]
        @registerMessage = "Password And Password confirm is not same."
      else
        begin
          User.create!(:user_name => params[:user_name], :user_pass => params[:user_pass], :user_email => params[:user_email])
          @registerMessage = "Successfully Registered!"
        rescue => exception
          @registerMessage = exception
        end
      end
      
    end
  end
end
