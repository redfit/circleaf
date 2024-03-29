Circleaf::Application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => 'authentications' }, skip: [:sessions]
  devise_scope :user do
    delete '/sessions' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :groups do
    resource :memberships, only: [:create, :destroy]
    resources :memberships, shallow: true, only: [:index, :update]
    resources :posts, only: [:index, :show, :create, :update, :destroy], shallow: true
    resources :events, shallow: true do
      resource :attendances, only: [:create, :destroy]
      resources :attendances, only: [:index, :update]
      resources :comments, only: [:create, :update, :destroy]
    end
  end

  scope :path => :my do
    resource :setting, :only => [:show, :edit, :update], as: :my_setting
    resource :email, only: [:show, :edit, :update], as: :my_email do
      member do
        get 'confirmation/:hash' => :confirmation, hash: /[0-9a-f]+/, as: :confirmation
      end
    end
    root 'users#show', as: :my_root
  end
  resource :my, controller: :users, only: [:edit, :update, :destroy]
  
  resources :users, only: [:show]

  post 'pusher/authentication' => 'pushers#authentication'
  
  get 'about' => 'pages#about'
  get 'policy' => 'pages#policy'
  get 'terms' => 'pages#terms'
  root 'pages#index'
end
