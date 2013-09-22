module RolesHelper
  def users_left_to_add
    (User.active-@role.users).sort_by {|user| user.last_first}.map {|user| [user.last_first, user.id]}
  end
end
