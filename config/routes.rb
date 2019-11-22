Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#welcome'

  scope module: 'users' do
    resources :sessions, only: :create
    delete 'sessions', to: 'sessions#destroy'
  end

  resources :users, only: %i[index show create update destroy] do
    scope module: 'users' do
      resources :tasks, only: %i[index show create]
      get 'users_supervised', to: 'supervisors#index'
      post 'supervisor', to: 'supervisors#create'
      get 'categories/:category/tasks', to: 'users/tasks/categories#index'
    end
  end

  scope module: 'users' do
    resources :tasks, only: %i[update destroy]
    delete 'users_supervised', to: 'supervisors#destroy'
  end
end
