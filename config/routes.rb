Rails.application.routes.draw do


  
  
  root to: 'photos#index', category: 'random'
  
    
  resources :photos
  resources :categories
end
