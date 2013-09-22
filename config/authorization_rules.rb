authorization do
  role :admin do
    has_permission_on :users, :to => [:create, :edit, :find, :update,:show,:index, :new]
    has_permission_on :admin, :to => :index
    has_permission_on :roles, :to => [:show, :index, :add_user, :remove_user]
  end
end

