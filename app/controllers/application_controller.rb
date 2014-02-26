class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  after_filter :set_access_control_headers

  # respond to options requests with blank text/plain as per spec
  def cors_preflight_check
    logger.info ">>> responding to CORS request"
    render :text => '', :content_type => 'text/plain'
  end

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = '*' 
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*' 
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  

  protected
  def authenticate!
  	if params[:api_key]
  		authenticate_client_with_token!
  	elsif params[:token]
  		authenticate_phone!
  	else
  		authenticate_client!
  	end
  end

  def authenticate_phone!
  	if Phone.exists? token: params[:token]
      Phone.where(token: params[:token]).first.ping!
    else
  		render text: "Unauthorized", status: 401 and return 
  	end
  end

  def authenticate_client_with_token!
  	if Client.exists? api_key: params[:api_key]
  		client = Client.find_by_api_key params[:api_key]
	    if client && Devise.secure_compare(client.api_key, params[:api_key])
	      sign_in client, store: false
	      authenticate_client!
	    end
    else
  		render text: "Unauthorized", status: 401 and return 
    end
  end

end
