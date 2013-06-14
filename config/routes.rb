IshikitakaiCom::Application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => 'authentications' }, skip: [:sessions]
  devise_scope :user do
    delete '/sessions' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :groups do
    resource :memberships, only: [:create, :destroy]
    resources :posts, only: [:index, :show, :create, :update, :destroy], shallow: true
    resources :events, shallow: true do
      resource :attendances, only: [:create, :destroy]
    end
  end
  post 'pusher/authentication' => 'pushers#authentication'
  root 'pages#index'
end
