class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #
  protect_from_forgery with: :exception
  before_filter :authorize
  helper_method :current_user

  def current_user
    @current_user
  end

  def permission_denied
    render 'shared/permission_denied', :layout => 'layouts/login'
  end

  protected
  def authorize
    unless @current_user = User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end

end
