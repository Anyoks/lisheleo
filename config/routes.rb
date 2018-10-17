Rails.application.routes.draw do
  
  resources :sms
  devise_for :admins

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
