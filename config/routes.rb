Rails.application.routes.draw do
  root :to => 'pages#index'

  get 'courses/search(/:query)', to: 'courses#search', as: :courses_search
  resources :courses, only: [:index, :show]
  resources :sections, only: [:show]
  
  get 'instructors/search(/:query)', to: 'instructors#search', as: :instructors_search
  resources :instructors, only: [:index, :show]
  resources :course_offerings, only: [:show]

  get 'grades/courses(/:uuid)', to: 'grades#course', as: :course_grades
  get 'grades/sections(/:uuid)', to: 'grades#section', as: :section_grades
  get 'grades/course_offerings(/:uuid)', to: 'grades#course_offering', as: :course_offering_grades
  get 'grades/instructors(/:id)', to: 'grades#instructor', as: :instructor_grades
end
