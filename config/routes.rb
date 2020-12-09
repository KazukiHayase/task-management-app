Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tasks 
  post "tasks/sort", to: "tasks#sort", as: "sort_tasks"
  post "tasks/search", to: "tasks#search", as: "search_tasks"
  get  "login", to: "sessions#new"
  post  "login", to: "sessions#create"
  delete  "logout", to: "sessions#destroy"
end
