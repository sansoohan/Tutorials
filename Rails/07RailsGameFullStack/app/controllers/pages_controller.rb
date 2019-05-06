class PagesController < ApplicationController
  @user
  def index
    if @user == nil
      render template: "pages/login/index"
    else
      render template: "pages/home/index"
    end
  end

  def user
    @user
  end
  def user=(newUser)
    @user = newUser
  end
end
