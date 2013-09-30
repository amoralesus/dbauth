class Person < ActiveRecord::Base
  has_many :jobs

  def self.statuses
    %w(active inactive)
  end
end
