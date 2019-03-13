Rails.application.routes.draw do
  get 'events/show'
  get 'events/index'
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  resources :events, only: [:show, :index , :new , :create] do
    resources :comments, only: [:create, :new]
    resources :attendances, only: [:create, :edit, :update, :destroy]

  end

  resources :users, only: [:show ] do
    resources :avatar, only: [:new, :create]
  end
  resources :homes, only: [:index]
  root 'home#index'
end
