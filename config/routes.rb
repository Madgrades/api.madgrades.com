Rails.application.routes.draw do
  root to: 'pages#index'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]

  namespace :api, as: '' do
    root to: 'pages#index'

    get 'courses/search(/:query)', to: 'courses#search', as: :courses_search
    get 'courses/:id/grades', to: 'grades#course', as: :course_grades
    resources :courses, only: [:index, :show]

    get 'instructors/search(/:query)', to: 'instructors#search', as: :instructors_search
    get 'instructors/:id/grades', to: 'grades#instructor', as: :instructor_grades
    resources :instructors, only: [:index, :show]

    get 'course_offerings/:id/grades', to: 'grades#course_offering', as: :course_offering_grades
    resources :course_offerings, only: [:show]

    get 'sections/:id/grades', to: 'grades#section', as: :section_grades
    resources :sections, only: [:show]

    get 'subjects/search(/:query)', to: 'subjects#search', as: :subjects_search
    get 'subjects/:id/courses', to: 'subjects#courses', as: :subject_courses
    resources :subjects, only: [:index, :show]
  end
end
