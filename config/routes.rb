Rails.application.routes.draw do
  resources :companies do
    resources :contacts, only: %i[create edit update destroy]
    resources :jobs do
      resources :comments, only: %i[create]
    end
  end
  resources :categories
  resources :jobs, only: %i[index new]
  resources :dashboard, only: %i[index]
end
