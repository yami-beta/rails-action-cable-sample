Rails.application.routes.draw do
  resources :users
  resources :user_sessions
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  get 'rooms/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
