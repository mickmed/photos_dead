Rails.application.routes.draw do


  
  
  root to: 'photos#index', category: 'newest'
  
    
  resources :photos
  resources :categories
end
