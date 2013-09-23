class Job < ActiveRecord::Base
  belongs_to :person
  belongs_to :company

  validates_presence_of :person_id, :company_id, :title


end
