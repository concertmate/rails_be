Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do 
    namespace :v1 do 
      resources :events, only: [:show, :index] # this will be all events in db no matter the user
      resources :users, only: [:show, :create, :update, :destroy, :index] do
        resources :user_events, only: [:create, :show, :index, :destroy] #user_events controller to pull events for a user (and create and delete)
      end
      resources :artists, only: [:index, :create, :destroy]
      resources :attendees, only: [:index, :create, :destroy]
    end
  end
end
