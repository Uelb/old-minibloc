Mocti::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :clients
  resources :clients, only: [:update, :edit, :show]
  get '/api/*path', to: 'api#get', defaults: { format: 'json' }
  match '/*path' => 'application#cors_preflight_check', :via => :options
  get 'documentation', to: 'pages#documentation'
  resources :messages, only: [:create, :show, :update, :index, :new] do
  	collection do
  		post 'answers', to: "messages#answers"
  	end
    member do
      get 'answers', to: "messages#get_answers"
    end
  end
  resources :phones, only: [:create, :index, :new, :update] do 
    collection do 
      post 'resend_activation_code'
      post 'activate'
    end
    member do 
      post 'use'
      post 'unuse'
    end
  end
  resources :statuses, only: [:show, :index]
  root 'messages#index'

  resources :charges
end
