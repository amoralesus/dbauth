Dbauth::Application.routes.draw do

  resources :roles do
    member do
      post 'add_user'
      delete 'remove_user'
    end
  end

  resources :users, :only => [:index, :show, :new, :create, :edit, :update] do
    collection do
      get 'find'
    end
  end

  resources :password_changes, :only => [:new, :create]

  resources :password_recoveries, :only => [:new, :create, :edit, :update]

  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

  root :to => 'admin#index'

end
