Rails.application.routes.draw do
  resources :post_category_relations
  resources :categories
  resources :posts
  resources :menus
  root   'home#index'
  
  #get 'business_users/show'

  devise_for :business_users, controllers: {
    sessions: 'business_users/sessions',
    passwords: 'business_users/passwords',
    registrations: 'business_users/registrations'
  }

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :business_users, :only => [:show, :edit, :update]

  get '/buser_mypage' => 'business_users#buser_mypage'
  get 'business_users/:id'   =>  'business_users#show'

  resources :users, :only => [:show, :edit, :update]

  get 'mypage', to: 'users#mypage'
  get '/mypage' => 'users#mypage'

  get "/" => "home#index"
  get 'home/index'

  get 'pages/faq1'
  get 'pages/faq2'
  get 'pages/pricing'
  get 'pages/how2use'
  get 'pages/category'
  
  get 'pages/business_user_register'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
