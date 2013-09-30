class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.roles
    %w(admin).map {|name| Role.find_or_create_by(:title => name)}
  end
  
end
