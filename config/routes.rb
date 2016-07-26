Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/backstage', as: 'rails_admin'
  resources :districts
  
  root to: 'districts#index'
  
end
