Rails.application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => "callbacks"}
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "dashboard#index"
  get "/error404" => "dashboard#error404"
  get "/error500" => "dashboard#error500"
  get "/error403" => "dashboard#error403"
  get 'opportunities' => 'opportunities#index'
  get "/profile_volunteer" => "dashboard#profile_volunteer"
  get "/profile_organization" => "organization#profile_organization"

  resources :organization
  get "/hours" => "dashboard#hours", as: "hours"
  get "/notifs" => "dashboard#notifs", as: "notifs"
  get "/history" => "dashboard#history", as: "history"
  get "/notifications" => "organization#notifications", as: "notifications"
  get "/stats/:id" => 'organization#stats', as: "stats"
  get "/volunteers/:id" => 'organization#volunteers', as: "volunteers"
  get "/reviews/:id" => 'organization#reviews', as: "reviews"
  get "/histories/:id" => 'organization#histories', as: "histories"
  get "/opps/:id" => 'organization#opps', as: "opps"
  get "/opportunities/:id/clone" => 'opportunities#clone', as: "clone_opportunity"
  post 'organization/approve'
  post 'organization/deny'

  get "/stat" => "admin#statistics"
  get "/requests" => "admin#requests"
  get "/organizations" => "admin#organizations"

  resources :opportunities
  get "/secret" => "organization#secret"
  get '/auth/duke-oauth2/callback', to: 'dashboard#create'
  get "/feed_volunteer" => "dashboard#feed_volunteer"
  post "/feed_volunteer" => "dashboard#feed_volunteer", as: "temp_form"
  post "/feed_organization" => "organization#feed_organization", as: "org_form"
  get "/feed_organization" => "organization#feed_organization"
  get "/admin" => "admin#admin_home"
  get "/posting_volunteer" => "dashboard#posting_volunteer"
  get "/opportunities/:id/contact_volunteers" => "opportunities#contact_volunteers", as: "contact_volunteers"
  post "/opportunities/:id/contact" => "opportunities#contact", as: "contact_path"
  get "/opportunities/:id/view_volunteers" => "opportunities#view_volunteers", as: "view_volunteers"
  get "/organization/:id/like" => "organization#like", as: "like_action"
  get "/opportunities/:id/like" => "opportunities#like", as: "like_action_opportunity"

  get "/admin_home" => "admin#admin_home"
  post "/admin_home" => "admin#admin_home", as: "admin_form"
  get "/onboard" => "onboarding#onboard"
  get"/volunteer_partial" => "onboarding#volunteer_partial"
  get"/organization_partial" => "onboarding#organization_partial"
  get "/complete" => "onboarding#complete", as: "onboarding_complete"
  post "/complete" => "onboarding#complete", as: "onboarding_complete_form"
  post 'admin/approve'
  post 'admin/deny'

  get "/edit_user/:id" => "dashboard#edit_user", as: "edit_user"
  patch "/profile_volunteer" => "dashboard#update_user", as: "update_user"
  resources :dashboard, only: [:show]

  get "/edit_custom/:id" => "organization#edit_custom", as: "edit_custom"

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
end
