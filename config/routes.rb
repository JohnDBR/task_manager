Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#welcome'

  scope module: 'users' do
    resources :sessions, only: :create
    delete 'sessions', to: 'sessions#destroy'
  end

  namespace :users do
    resources :tasks, only: %i[show update]
  end

  resources :users, only: %i[index show create update destroy] do
    get 'users_supervised', to: 'supervisors#index'
    post 'supervisor', to: 'supervisors#create'
    scope module: 'users' do
      resources :tasks, only: %i[index create update]
      get 'categories/:category/tasks', to: 'tasks/categories#index'
    end
  end

  scope module: 'users' do
    resources :tasks, only: %i[update destroy]
  end
  delete 'users_supervised/:id', to: 'supervisors#destroy'
end
