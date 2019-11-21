Rails.application.routes.draw do
  get 'tasks/index'
  get 'tasks/show'
  get 'tasks/create'
  get 'tasks/update'
  get 'tasks/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#welcome'

  scope module: 'users' do
    resources :sessions, only: :create
    delete 'sessions', to: 'sessions#destroy'
  end

  resources :users, only: %i[index show create update destroy]
end
