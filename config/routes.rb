Rails.application.routes.draw do


  
  
  resources :messages
  root to: 'photos#index', category: 'random'
  
    
  resources :photos
  resources :categories
  resources :messages
end
