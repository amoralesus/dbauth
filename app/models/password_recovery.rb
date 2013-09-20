class PasswordRecovery < ActiveRecord::Base
  belongs_to :user
  after_create :generate_recovery_hash
  after_create :set_initial_status

  def self.pending
    where('status = ?', 'pending')
  end

  def self.statuses
    %w(pending completed expired)
  end

  def generate_recovery_hash
    prefix = self.user_id.to_s + self.id.to_s
    chars = (('a'..'z').to_a+(0..9).to_a)
    self.recovery_id = prefix + (0..50).map {chars[rand(35)]}.join
    self.save
  end

  def set_initial_status
    self.user.password_recoveries.pending.update_all(:status => 'expired')
    self.status = 'pending'
    self.save
    send_mailer
  end

  def send_mailer
    AdminMailer.forgot_password(self).deliver
  end

  def complete!(new_password)
    self.user.password = new_password
    self.user.save!
    self.update_attribute(:status, 'completed')
  end



end
