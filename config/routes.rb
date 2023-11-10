Rails.application.routes.draw do
  root "static_pages#top"
  
  resources :users, only: %i[new create]
  resources :boards, only: %i[index]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end