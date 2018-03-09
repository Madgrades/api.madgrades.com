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

    get 'courses/:id/grades', to: 'courses#grades', as: :course_grades
    resources :courses, only: [:index, :show]

    get 'instructors/search', to: 'instructors#search', as: :instructors_search
    resources :instructors, only: [:index, :show]

    resources :course_offerings, only: [:show]

    resources :sections, only: [:show]

    resources :subjects, only: [:index, :show]
  end
end
