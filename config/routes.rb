Rails.application.routes.draw do
  root "static_pages#top"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  resources :users, only: %i[new create]
  resources :password_resets, only: %i[new create edit update]
  resource :profile, only: %i[new show edit update]
  resources :boards do
    resources :comments, only: %i[create edit destroy update], shallow: true
    resources :bookmarks, only: %i[create edit destroy]
    collection do
      get "bookmarks"
      get "search"
    end
  end
  # 管理画面のルーティング
  namespace :admin do
    root "dashboards#index"
    resource :dashboard, only: %i[index]
    get 'login' => 'user_sessions#new', :as => :login
    post 'login' => "user_sessions#create"
    delete 'logout' => 'user_sessions#destroy', :as => :logout
  end
end