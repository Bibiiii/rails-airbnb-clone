Rails.application.routes.draw do
  get "/profile/:id/edit", to: "profiles#edit"
  patch "/profile/:id", to: "profiles#update", as: "profile_edit"
  get "/profile/:id/show", to: "profiles#show", as: "profile_show"
  devise_for :users
  root to: 'pages#home'
  resources :users do
    resources :animals
  end

  mount Attachinary::Engine => "/attachinary"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
