require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "send email to forgot user" do
    user = User.create(:username => 'someuser', :password => 'somepassword', :email => 'someemail@moralitos.com')
    recovery = user.password_recoveries.create
    assert_equal(1, ActionMailer::Base.deliveries.size)
  end
end
