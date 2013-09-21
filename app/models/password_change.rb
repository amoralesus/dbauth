class PasswordChange < ActiveRecord::Base
  validates_presence_of :user_id

  belongs_to :user

  validate :enforce_current_password
  
  before_save :change_user_password

  attr_accessor :current_password
  attr_accessor :new_password
  attr_accessor :new_password_confirmation

  def enforce_current_password
    self.errors.add(:current_password, 'Can not be blank') if current_password.blank?
  end
  
  def change_user_password
    begin
      user.enforce_password_requirements = true
      user.password = new_password
      user.password_confirmation = new_password_confirmation
      user.save!
    rescue Exception => e
      user.errors.full_messages.each {|error| self.errors.add(:base, error)}
      false
    end
  end

end
