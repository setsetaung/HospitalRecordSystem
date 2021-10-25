Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root "doctors#home"
  
  resources :patients
  resources :doctors do
    resources :appointments, only: [:index,:new, :create, :edit, :update, :destroy]
    
  end

  resources :patients do
    resources :notes 
  end
end