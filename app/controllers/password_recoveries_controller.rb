class PasswordRecoveriesController < ApplicationController
  skip_before_filter :authorize

  def new
    @password_recovery = PasswordRecovery.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.password_recoveries.create
      redirect_to login_url, :notice => 'You should receive an email with a link to reset your password shortly.'
    else
      redirect_to new_password_recovery_path, :alert => "Could not find user with email '#{params[:email]}' in this system."
    end
  end
end
