class AdminMailer < ActionMailer::Base
  default from: "smtpsender@moralitos.com"

  def forgot_password(password_recovery)
    @user = password_recovery.user
    @url = edit_password_recovery_url(password_recovery, :recovery_id => password_recovery.recovery_id)
    
    mail(to: @user.email, subject: 'You forgot your password to this site')
  end
end
