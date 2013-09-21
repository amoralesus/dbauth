require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user with a password should save" do
    user = User.new(:username => 'one', :email => 'albertomoreales@moralitos.com', :password => 'password')
    user.save
    assert_equal([], user.errors.full_messages, "Expected no errors but go #{user.errors.full_messages}")
  end

  test "a user should authenticate correctly" do
    user = User.new(:username => 'testing', :email => 'other@other.com', :password => 'testing')
    user.save!
    assert(User.authenticate('testing', 'testing'), "did not authenticate, #{user.errors.full_messages.inspect}")
  end
end
