ApiTactic::Application.routes.draw do
  get '/api/*path', to: 'api#get', defaults: { format: 'json' }
  match '/*path' => 'application#cors_preflight_check', :via => :options
end
