Rails.application.routes.draw do
  
  resources :clients
  resources :bookings
  resources :sms
  devise_for :admins

  namespace :api do
    namespace :v1 do
      get '/sms', :to => 'sms#create'
      post '/sms', :to => 'sms#create'
      # resources :sms, only: [:create]
      # get '/drivers/tuktuk_drivers'
      # get '/drivers/bajaj_drivers'
    end
  end

  authenticated :admin do
    root 'connections#index', as: :authenticated_admin
  end

   devise_scope :admin do
      get 'sign_in', to: 'devise/sessions#new'
      get 'sign_up', to: 'devise/registrations#new'
  end

  resources :connections

  root 'connections#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
