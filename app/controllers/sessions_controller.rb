class SessionsController < ApplicationController

  skip_before_filter :authorize

  layout 'login'

  def new
    @url = params[:url] 
  end

  def create
    if user = User.authenticate(params[:username], params[:password])
      cookies.signed[:user_id] = {:value => user.id}
      originating_url = Rack::Utils.unescape(params[:url].to_s)
      redirect_url = originating_url.blank? ? root_url : originating_url
      redirect_to  redirect_url
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    cookies.signed[:user_id] = {:value => '-1'}
    redirect_to root_url
  end

end
