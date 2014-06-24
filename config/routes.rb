OuiShareFest::Application.routes.draw do

  resources :traductions
  resources :individual_types

  # SetLanguage routes
  namespace :set_language do
    get :set_new_language, :as => "set_new_language"
  end
  # get 'set_language/set_new_language', :as => "set_new_language"

  # Admin routes
  resources :admin, only: [:index] do
    collection do
      get :export_users
      get :export_newsletter_subscribers
      get :users_list
      get :settings_list 
      get :strong_auth_access_page
      get :individuals_list
      get :individual_types_list
      get :restart_nginx_server
      post :validate_strong_auth    
    end
    member do
      get :individual_type
      post :toggle_admin
      post :toggle_setting
    end
  end

  resources :individuals

  # Devise routes  
  devise_for :users, :skip => [:sessions, :registrations], :path => ''
  devise_scope :user do
    get '/register', :to => 'devise/registrations#new', :as => 'user_registration'
    post '/register', :to => 'devise/registrations#create'
    get '/login', :to => 'devise/sessions#new', :as => 'new_user_session'
    post '/login', :to => 'devise/sessions#create'
    delete '/logout', :to => 'devise/sessions#destroy'
    # get '/password/change', :to => 'devise/registrations#edit', :as => 'change_password'
    # TODO: delete the route of cancel account, by delete defaut routes of registrations (:skip => [:registrations]) and only keeping custom ones
    end
  
  resources :users, only: [:index, :show, :edit, :update]

  # Home routes
  root :to => 'home#index'

  namespace :home, :path => nil do
    get :faq
    # get :contact
    # post :contact, :action => :contact_email
    get :site_off
    get :program
    get :about
    get :participants
    get :join
    get :fest2014
    # get :stories
    post :newsletter_collect_email
  end

  resources :stories, :only => [:index, :show], :singular => :story

  namespace :me do
    get :dashboard
    get :preferences
    get :edit_profile   
    get :change_password
    put :apply_change_password
    put :update_profile  
  end

  get '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure' 
    
end
