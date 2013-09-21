Dbauth::Application.routes.draw do

  resources :users, :only => [:index, :show, :new, :create, :edit, :update] do
    resources :password_changes, :only => [:new, :create]
  end

  resources :password_recoveries, :only => [:new, :create, :edit, :update]

  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  root :to => 'admin#index'

end
