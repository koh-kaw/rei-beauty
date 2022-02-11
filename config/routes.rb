Rails.application.routes.draw do

  # 営業時間設定
  get 'business_setting', to: 'off_businesses#show'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # カード
  resources :cards, only: [:new, :create, :show]
  
  #get 'cards/new'
  #get 'cards/show'

  # 面接チャット
  get 'interview_chat/:id' => 'interview_chats#show', as: 'interview_chat'
  resources :interview_chats, only: [:create]

  # 駅
  # ajax
  get '/users/company_select' => 'users#company_select'
  get 'ajax',         to: 'users#ajax'

  # ユーザー検索
  get 'user_search' => 'recruits#user_search'

  # ランキング
  get 'rankings/index'

  # チャット  
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  resources :rooms, only: %i(index show)
  resource :message, only: :create

  namespace :business_users do
    resources :rooms, only: %i(index show)
    resources :interview_rooms, only: %i(index show)
    resource :message, only: :create
  end

  # 領収書
  get 'reservations/receipt' #reservarions/receipt.pdfにアクセスすると動く
  get 'reservations/receipt', to: 'reservations#receipt'

  #施術者検索
  get 'recruits/index'
  #get 'recruits/show'
  #get 'recruits/new'
  #post 'recruits/create'
  resources :recruits, only: [:new, :create, :show]
  #post "recruits/new" => "recruits#new"
  #post "recruits/creat" => "recruits#creat"
  
  # レビュー
  resources :reviews  

  resource :buser_account, :only => [:show]

  get 'buser_accounts/show'
  
  namespace :accounts do
    get 'avatars/edit'
    get 'avatars/update'
  end
  
  namespace :accounts do
    get 'names/edit'
    get 'names/update'
  end

  get 'accounts/show'

  resources :post_category_relations
  resources :categories
  resources :posts
  resources :posts, only: [:show, :new, :create]
  
  resource :account, :only => [:show] do
    resource :name, :only => [:edit, :update], module: "accounts"
    resource :avatar, :only => [:edit, :update], module: "accounts"
  end

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
    passwords:     'users/passwords',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  
  resources :business_users, :only => [:show, :edit, :update] 

  get '/buser_mypage' => 'business_users#buser_mypage'
  get 'business_users/:id'   =>  'business_users#show'
  get 'business_users/:id/setting'   =>  'business_users#setting'
  get 'business_users/index'   =>  'business_users#index'
  

  #resources :users, :only => [:show, :edit, :update]
  resources :users  do
    member do
      get :personal
    end
  end
  
  resources :business_users  do
    member do
      get :revenue
    end
    resources :off_businesses
  end


  # マイページのルーティングにネスト
  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end

  # 記事詳細表示のルーティングにネスト
  #resources :posts, expect: [:index] do
  #  resource :favorites, only: [:create, :destroy]
  #end
  resources :business_users do
    resource :favorites, only: [:create, :destroy]
  end

  # 予約機能
  resources :posts do
    member do
      # 予約機能
      get 'preload'
      get 'preview'
    end
    resources :reservations
    resources :categories
  end 

  resources :reservations do
    member do
      get :receipt
      put :done_reserve
    end   
  end
  
  # 決済機能
  resources :reservations do
    collection do
      post 'pay'
    end
  end

  get '/your_reserves' => 'reservations#your_reserves'
  #get '/done_reserve' => 'reservations#done_reserve'

  
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
  get 'pages/terms'
  get 'pages/covid'
  get 'pages/u_rules'
  get 'pages/b_rules'
  get 'pages/policy'
  
  get 'search' => 'posts#search'
  get 'pickup' => 'posts#pickup'
  
  get 'pages/business_user_register'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
