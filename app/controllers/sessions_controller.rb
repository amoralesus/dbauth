class SessionsController < ApplicationController

  skip_before_filter :authorize

  layout 'login'

  def new
    session[:url] = Rack::Utils.unescape(params[:url].to_s)
  end

  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      redirect_to session[:url] || admin_url 
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_url
  end


end
