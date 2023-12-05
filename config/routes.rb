Rails.application.routes.draw do
  root "static_pages#top"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :boards do
    resources :comments, only: %i[create edit destroy update], shallow: true
    resources :bookmarks, only: %i[create edit destroy]
    collection do
      get "bookmarks"
      get "search"
    end
  end
end