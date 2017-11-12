Rails.application.routes.draw do
  resources :districts_iframe, only: [:index]
  resources :venues_iframes, only: [:index, :show]
  resources :venues
  mount RailsAdmin::Engine => '/backstage', as: 'rails_admin'
  resources :districts
  
  # root to: 'districts#index'
  
end
