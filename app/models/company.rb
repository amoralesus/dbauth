class Company < ActiveRecord::Base
  validates_presence_of :name, :status
  validates_uniqueness_of :name

  def self.statuses
    %w(client potential vendor locked_out_no_access)
  end

  def self.home_company
    Company.find_or_create_by_name_and_status_and_website('amorales.us', 'active', 'www.amorales.us')
  end

end
