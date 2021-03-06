Rails.application.routes.draw do
  get 'payments/new'

  get 'payments/create'

  root 'home#index'
  get '/search' => 'home#search'
  resources :postings do
    resources :comments
    resources :transactions
  end
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
    sessions: 'users/sessions' ,
    registrations: 'users/registrations'
  }

  resources :users, only: [:show, :update, :edit]
  resources :users do 
    member do 
      get "postings", to: "users#postings"
      get "transactions", to: "users#transactions"
        #this route responds to the path defined in form
    end
  end

  resources :payments, only: [:new, :create]

end