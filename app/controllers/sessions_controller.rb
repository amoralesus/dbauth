class SessionsController < ApplicationController

  skip_before_filter :authorize

  def new
  end

  def create
    debugger
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
  end

end
