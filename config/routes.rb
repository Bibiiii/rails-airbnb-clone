Rails.application.routes.draw do

  get "my_profile/edit", to: "profiles#edit"
  patch "my_profile/edit", to: "profiles#update", as: "profile_edit"

  get "/profile/:id/show", to: "profiles#show", as: "profile_show"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :users
  get "/about", to: "pages#about"
  resources :animals do
    resources :bookings, only: [:new, :create]
  end

  resources :conversations do
    resources :messages
  end

  resources :bookings, only: [:index, :show, :destroy, :requests]

  get '/animals/:id', to: 'animals#show', as: "animal_show"

  get '/my_profile', to: 'profiles#my_profile', as: "my_profile"

  get '/my_bookings', to: 'profiles#my_bookings'

  patch '/bookings/:id', to: 'bookings#update'

  get '/my_requests', to: 'profiles#my_requests'

  get '/my_requests/:id/accept', to: 'bookings#accept'

  get 'my_requests/:id/review', to: 'bookings#review'

  mount Attachinary::Engine => "/attachinary"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
