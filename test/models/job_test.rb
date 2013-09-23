require 'test_helper'

class JobTest < ActiveSupport::TestCase
  setup do
    @company = Company.new(:name => 'onecompany', :status => 'active')
    @company.save!
    @person = Person.new(:first_name => 'person1', :last_name => 'person1last', :status => 'active')
    @person.save
  end

  test "A job should require a company and a person" do
    job = @person.jobs.new(:company_id => @company.id, :title => 'cio', :status => 'active')
    job.save
    assert_equal([], job.errors.full_messages)
    assert_equal('active', job.status)
  end
end
