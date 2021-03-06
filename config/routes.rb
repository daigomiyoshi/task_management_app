Rails.application.routes.draw do
  root 'projects#index'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'
  delete 'logout', to: 'user_sessions#destroy'
  get 'projects/:project_id/:year/:month', to: 'work_results#show_monthly', as: 'work_result_monthly'
  get 'projects/:project_id/:year/:month/:day/new', to: 'work_results#new', as: 'new_work_result_daily'
  post 'projects/:project_id/:year/:month/:day/new', to: 'work_results#create'
  post 'projects/:project_id/:year/:month/:day/creat_without_work', to: 'work_results#creat_without_work'
  get 'projects/:project_id/:year/:month/:day', to: 'work_results#show', as: 'work_result_daily'
  get 'projects/:project_id/:year/:month/:day/edit', to: 'work_results#edit', as: 'edit_work_result_daily'
  patch 'projects/:project_id/:year/:month/:day/edit', to: 'work_results#update'
  delete 'projects/:project_id/:year/:month/:day', to: 'work_results#destroy', as: 'delete_work_result_daily'
  resources :payment_results, only: %i[index]
  resource :user_account, only: %i[show]
  namespace :admin do
    root 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    get 'logout', to: 'user_sessions#destroy'
    delete 'logout', to: 'user_sessions#destroy'
    resources :projects, only: %i[index new create edit update destroy] do
      resources :project_categories, only: %i[index new create edit update destroy]
    end
    resources :user_in_charges, only: %i[index new create edit update destroy]
    resources :payment_results do
      collection do
        get 'select_to_create'
      end
    end
    resources :user_accounts
  end
end
