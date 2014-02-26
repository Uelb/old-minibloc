class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
