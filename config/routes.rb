ApiTactic::Application.routes.draw do
  devise_for :clients
  get '/api/*path', to: 'api#get', defaults: { format: 'json' }
  match '/*path' => 'application#cors_preflight_check', :via => :options
  resources :clients, only: :update
  resources :messages, only: [:create, :show, :update, :index]
  resources :phones, only: :create
  resources :statuses, only: :show
  post '/messages/answers', to: 'messages#answer'
end
