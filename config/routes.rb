ApiTactic::Application.routes.draw do
  devise_for :clients
  get '/api/*path', to: 'api#get', defaults: { format: 'json' }
  match '/*path' => 'application#cors_preflight_check', :via => :options
  resources :clients, only: :update
  resources :messages, only: [:create, :show, :update, :index] do
  	collection do
  		post 'answers'
  	end
  end
  resources :phones, only: :create
  resources :statuses, only: :show
  root 'messages#index'
end
