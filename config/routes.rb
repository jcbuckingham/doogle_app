Rails.application.routes.draw do
  resources :search_result

  root 'search_result#index'
  post  '/create', to: 'search_result#index'
end