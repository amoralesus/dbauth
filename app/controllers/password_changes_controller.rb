class PasswordChangesController < ApplicationController
  def new
    @password_change = current_user.password_changes.new 
  end

  def create
    @password_change = current_user.password_changes.new
    @password_change.current_password = params[:password_change][:current_password]
    @password_change.new_password = params[:password_change][:new_password]
    @password_change.new_password_confirmation = params[:password_change][:new_password_confirmation]

    if @password_change.save
      flash[:notice] = "Your password has been changed"
      redirect_to login_url
    else
      flash.now[:alert] = (@password_change.errors.full_messages.join('<br>'))
      render :new
    end
  end
end
