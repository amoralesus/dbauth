require 'test_helper'

class PasswordRecoveryTest < ActiveSupport::TestCase

  setup do
    @user = User.create(:username => 'my_user', :password => 'testing', :email => 'my_user@dot.com')
    @recovery = @user.password_recoveries.create
    @recovery.reload
  end

  test "the password recovery requires a user" do
    assert_equal(@user.id, @recovery.user_id)
  end

  test "a PasswordRecovery should have a unique hash for recover" do
    assert(@recovery.recovery_id.to_s.length > 50, "Expected a hash of 50 characters or more but got '#{@recovery.recovery_id}'")
    prefix = @user.id.to_s + @recovery.id.to_s
    assert_equal(prefix, @recovery.recovery_id.to_s[0..(prefix.length-1)])
  end

  test "The password recovery should be pending to start" do
    assert_equal('pending', @recovery.status)    
  end

  test "There should only be one password recovery active for a user" do
    second_recovery = @user.password_recoveries.create
    assert_equal(1, @user.password_recoveries.pending.count)
    assert_equal(1, @user.password_recoveries.where('status = ?', 'expired').count)
  end

  test "The creation of a new password recovery should email the user" do
    recovery_emails = ActionMailer::Base.deliveries.select {|email| email.body =~ /#{@recovery.recovery_id}/}
      assert_equal(1, recovery_emails.size)
  end

  test "The user should set a new password with the recovery" do
    new_password = 'somenewpassword'
    @recovery.complete!(new_password, new_password)
    @recovery.reload
    user = User.authenticate(@user.username, new_password)
    assert_equal(@user.id, user.id)
    assert_equal('completed', @recovery.status)
  end

  test "The user should not set a new password if there is no password_confirmation" do
    new_password = 'somenewpassword'
    @recovery.complete!(new_password, nil)
    assert_equal(["Password confirmation can not be blank"], @recovery.errors.full_messages)
  end

  test "The user should not set a new password if it is too short" do
    new_password = 'sofd'
    @recovery.complete!(new_password, new_password)
    assert_equal(["Password needs to be at least 6 characters long"], @recovery.errors.full_messages)
  end
end
