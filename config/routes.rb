Rails.application.routes.draw do
  

  # resources :admin do
  #   # get :make_moderator
  #   # get :make_normal_user
  #   delete 'admin/:id' => 'user#destroy', :via => :delete #, :as => :admin_destroy_user
  #   get 'admin/:id' => 'staff#show', as: :admin
  # end
  get 'staff/index'
  get 'staff/' => 'staff#index'
  get 'staff/:id' => 'staff#show', as: :admin

  get 'staff/show'

  resources :centers
  get 'dashboard', :to => 'dashboard#index'

  resources :available_times
  resources :programs
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
    root 'admin/dashboard#index', as: :authenticated_admin
  end

   devise_scope :admin do
      get 'sign_in', to: 'devise/sessions#new'
      get 'sign_up', to: 'devise/registrations#new'
  end

  resources :connections

  root 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
