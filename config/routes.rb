Rails.application.routes.draw do
  root 'projects#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resource :user_account, only: %i[show edit update new create destroy]
  get 'projects/:project_id/:year/:month', to: 'work_results#show_monthly', as: 'work_result_monthly'
  get 'projects/:project_id/:year/:month/:day', to: 'work_results#new', as: 'new_work_result_daily'
  put 'projects/:project_id/:year/:month/:day', to: 'work_results#create', as: 'create_work_result_daily'
  get 'projects/:project_id/:year/:month/:day', to: 'work_results#show', as: 'work_result_daily'
  get 'projects/:project_id/:year/:month/:day/edit', to: 'work_results#edit', as: 'edit_work_result_daily'
  patch 'projects/:project_id/:year/:month/:day', to: 'work_results#update', as: 'update_work_result_daily'
  delete 'projects/:project_id/:year/:month/:day', to: 'work_results#destroy', as: 'delete_work_result_daily'
end
