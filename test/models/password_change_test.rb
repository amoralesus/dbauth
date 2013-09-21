require 'test_helper'

class PasswordChangeTest < ActiveSupport::TestCase
  setup do
    user = User.new(:password => 'testingsomething', :username => 'onetwofive', :email => 'onetowfive@dot.com')
    user.save!
    @user = User.authenticate('onetwofive', 'testingsomething')
    raise "could not get back user" unless @user.id == user.id
  end

  test "A new password change should require the current password" do
    password_change = @user.password_changes.new(:current_password => nil, :new_password => '1234566', :new_password_confirmation => '1234566')
    password_change.save
    assert_equal(["Current password Can not be blank"], password_change.errors.full_messages)
  end

  test "A new password change should require same new_password and new_password_confirmation" do
    password_change = @user.password_changes.new(:current_password => 'testingsomething', :new_password => '12345686', :new_password_confirmation => '1234566')
    password_change.save
    assert_equal(["Password confirmation doesn't match Password"], password_change.errors.full_messages)
  end

  test "A new password chagne should work with proper inputs" do
    password_change = @user.password_changes.new(:current_password => 'testingsomething', :new_password => '12345686', :new_password_confirmation => '12345686')
    password_change.save
    assert_equal([], password_change.errors.full_messages)
    assert_equal(@user.id, User.authenticate(@user.username, '12345686' ).id)
  end
end
