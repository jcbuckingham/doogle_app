Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :search_result

  root 'search_result#index'
  post  '/create', to: 'search_result#index'
end