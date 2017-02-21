Rails.application.routes.draw do
  get "my_profile/edit", to: "profiles#edit"
  patch "my_profile/edit", to: "profiles#update", as: "profile_edit"

  get "/profile/:id/show", to: "profiles#show", as: "profile_show"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :users
  resources :animals do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index, :show, :destroy]
  get '/my_profile', to: 'profiles#my_profile', as: "my_profile"

  mount Attachinary::Engine => "/attachinary"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
