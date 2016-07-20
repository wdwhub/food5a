Rails.application.routes.draw do
  resources :districts
  
  root to: 'districts#index'
  
end
