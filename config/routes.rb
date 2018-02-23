Rails.application.routes.draw do
  get 'courses/search(/:query)', to: 'courses#search'
  resources :courses, only: [:index, :show]
  resources :sections, only: [:index, :show]
  resources :instructors, only: [:index, :show]
  resources :grade_distributions, only: [:show]
  resources :course_offerings, only: [:index, :show]
end
