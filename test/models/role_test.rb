require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  setup do
    @user = User.new(:email => 'admin@admin.com', :username => 'adminusername')
    @user.save!
    Role.roles
  end

  test "An admin role should have at least one user" do
    admin_role = Role.find_by_title('admin')
    admin_role.users << @user
    assert(admin_role.users.include?(@user), "Expected user to be an admin")
  end
end
