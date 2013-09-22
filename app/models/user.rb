class User < ActiveRecord::Base
  has_and_belongs_to_many :roles

  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates_presence_of :status
  validates :password, :confirmation => true, :if => :enforce_password_requirements
  validate :password_must_be_present, :if => :enforce_password_requirements
  validate :validate_password_requirements, :if => :enforce_password_requirements

  attr_accessor :enforce_password_requirements
  attr_accessor :password_confirmation
  attr_reader :password

  has_many :password_recoveries
  has_many :password_changes

  before_validation :set_initial_status, :on => :create


  class << self
    
    def active
      where('status = ?', 'active').order('last_name, first_name')
    end

    def statuses
      %w(active inactive)
    end

    def authenticate(name, password)
      if user = find_by_username_and_status(name, 'active')
        if user.hashed_password == encrypt_password(password, user.salt)
          user
        end
      end
    end

    def encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "wibble" + salt)
    end
  end

  def set_initial_status
    self.status = 'active' if self.status.blank?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def last_first
    "#{last_name}, #{first_name}"
  end

  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def role_symbols
    roles.map {|role| role.title.to_sym}
  end

  private
  
  def password_must_be_present
    errors.add(:password, "Missing password" ) unless hashed_password.present?
  end

  def validate_password_requirements
    errors.add(:password, "needs to be at least 6 characters long") if password.to_s.length < 6
    errors.add(:password_confirmation, "can not be blank") if password_confirmation.to_s.length < 1
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end

