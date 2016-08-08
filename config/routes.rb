Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  #get 'static_pages/help'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
end
