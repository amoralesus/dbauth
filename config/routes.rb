Dbauth::Application.routes.draw do

  resources :roles

  resources :users, :only => [:index, :show, :new, :create, :edit, :update] do
    collection do
      get 'find'
    end
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
