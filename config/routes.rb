Rails.application.routes.draw do
  resources :post_category_relations
  resources :categories
  resources :posts
  resources :posts, only: [:show, :new, :create]
  
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

  #resources :users, :only => [:show, :edit, :update]
  resources :users  do
    member do
      get :personal
    end
  end

  # マイページのルーティングにネスト
  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end

  # 記事詳細表示のルーティングにネスト
  resources :posts, expect: [:index] do
    resource :favorites, only: [:create, :destroy]
  end
  
  get 'mypage', to: 'users#mypage'
  get '/mypage' => 'users#mypage'

  get "/" => "home#index"
  get 'home/index'

  get 'posts/index'
  
  get 'reserve/index'

  get 'pages/faq1'
  get 'pages/faq2'
  get 'pages/pricing'
  get 'pages/how2use'
  get 'pages/category'
  
  get 'search' => 'posts#search'
  
  get 'pages/business_user_register'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
