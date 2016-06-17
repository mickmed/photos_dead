Rails.application.routes.draw do


  root  'photos#index'
  
  resources :photos
  resources :categories
end
