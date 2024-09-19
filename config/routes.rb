Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do 
    namespace :v1 do 
      resources :events, only: [:show, :index] 
      resources :users, only: [:show, :create, :update, :destroy, :index] do
        resources :user_events, only: [:create, :show, :index, :destroy] 
      end
      resources :artists, only: [:index, :create, :destroy]
      resources :attendees, only: [:index, :create, :destroy]
      get '/concerts', to: 'concert#show' 
    end
  end
end
