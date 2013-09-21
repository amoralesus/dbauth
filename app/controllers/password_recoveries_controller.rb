class PasswordRecoveriesController < ApplicationController
  skip_before_filter :authorize
  layout 'login'

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

  def edit
    @password_recovery = PasswordRecovery.pending.find_by_recovery_id(params[:recovery_id])
    unless @password_recovery
      redirect_to new_password_recovery_path, :alert => "The password recovery token was not found, probably it is no longer valid. Please request a new one."
    end
  end

  def update
    @password_recovery = PasswordRecovery.pending.find_by_recovery_id(params[:recovery_id])
    if @password_recovery
      if @password_recovery.complete!(params[:password], params[:password_confirmation])
        redirect_to login_url, :notice => 'Password updated'
      else
        flash.now[:alert] = @password_recovery.errors.full_messages.join(',')
        render :edit
      end
    else
      redirect_to new_password_recovery_path, :alert => "The password recovery token was not found. Probably it is no longer valid. Please request a new one."
    end
  end
end

