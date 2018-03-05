Rails.application.routes.draw do
  root to: 'pages#index'

  # user authentication
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'auth/:provider/disconnect', to: 'pages#disconnect_provider', as: 'disconnect_provider'

  # api token
  get 'regenerate_api_token', to: 'pages#regenerate_api_token', as: 'regenerate_api_token'

  # user sessions
  get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :sessions, only: [:create, :destroy]

  namespace :v1, as: '' do
    root to: 'pages#index'

    get 'terms', to: 'terms#index', as: :terms

    get 'courses/:id/grades', to: 'grades#course', as: :course_grades
    resources :courses, only: [:index, :show]

    get 'instructors/search', to: 'instructors#search', as: :instructors_search
    get 'instructors/:id/grades', to: 'grades#instructor', as: :instructor_grades
    resources :instructors, only: [:index, :show]

    get 'course_offerings/:id/grades', to: 'grades#course_offering', as: :course_offering_grades
    resources :course_offerings, only: [:show]

    get 'sections/:id/grades', to: 'grades#section', as: :section_grades
    resources :sections, only: [:show]

    get 'subjects/search', to: 'subjects#search', as: :subjects_search
    get 'subjects/:id/courses', to: 'subjects#courses', as: :subject_courses
    resources :subjects, only: [:index, :show]
  end
end
