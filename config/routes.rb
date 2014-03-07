ApiTactic::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :clients
  get '/api/*path', to: 'api#get', defaults: { format: 'json' }
  match '/*path' => 'application#cors_preflight_check', :via => :options
  resources :clients, only: [:update, :edit, :show]
  resources :messages, only: [:create, :show, :update, :index, :new] do
  	collection do
  		post 'answers'
  	end
  end
  resources :phones, only: [:create, :index, :new, :update] do 
    collection do 
      post 'resend_activation_code'
      post 'activate'
    end
  end
  resources :statuses, only: :show
  root 'messages#index'
end
