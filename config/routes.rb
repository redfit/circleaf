IshikitakaiCom::Application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => 'authentications' }, skip: [:sessions]
  devise_scope :user do
    delete '/sessions' => 'devise/sessions#destroy', as: :destroy_user_session
  end
  root 'pages#index'
end
