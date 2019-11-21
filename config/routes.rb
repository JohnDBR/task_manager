Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#welcome'

  scope module: 'users' do
    resources :sessions, only: :create
    delete 'sessions', to: 'sessions#destroy'
  end

  resources :users, only: %i[index show create update destroy]
end
