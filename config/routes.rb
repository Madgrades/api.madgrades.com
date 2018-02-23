Rails.application.routes.draw do
  root :to => 'pages#index'

  get 'courses/search(/:query)', to: 'courses#search'
  resources :courses, only: [:index, :show]
  resources :sections, only: [:show]
  
  get 'instructors/search(/:query)', to: 'instructors#search'
  resources :instructors, only: [:index, :show]
  resources :course_offerings, only: [:show]
end
