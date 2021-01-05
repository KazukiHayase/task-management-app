Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks 
  resources :labels, only: [:index, :create, :destroy] 
  post "tasks/sort", to: "tasks#sort", as: "sort_tasks"
  post "tasks/search", to: "tasks#search", as: "search_tasks"
  get  "login", to: "sessions#new"
  post  "login", to: "sessions#create"
  delete  "logout", to: "sessions#destroy"
  scope :admin do
    resources :users
  end
  match '*path' , to: 'application#routing_error', via: :all
end
