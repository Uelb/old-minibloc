class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  after_filter :set_access_control_headers
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_session_variables

  # respond to options requests with blank text/plain as per spec
  def cors_preflight_check
    logger.info ">>> responding to CORS request"
    render :text => '', :content_type => 'text/plain'
  end

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = '*' 
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*' 
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-CSRF-Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  protected
  def authenticate!
  	if !params['api_key'].blank?
  		authenticate_client_with_token!
  	elsif !params[:token].blank?
  		authenticate_phone!
  	else
  		authenticate_client!
  	end
  end

  def authenticate_phone!
  	if !Phone.exists? token: params[:token]
  		render text: "Unauthorized", status: 401 and return 
  	end
  end

  def authenticate_client_with_token! 
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    api_key = params['api_key']
    client = Client.find_by_api_key api_key
    if client && Devise.secure_compare(client.api_key, api_key)
      sign_in client, store: false
    else
      render text: "Unauthorized", status: 401 and return 
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def set_session_variables
    session[:client_count] = Client.count
    session[:message_count] = Message.count
  end

end
