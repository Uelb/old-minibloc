class ClientsController < ApplicationController
	before_filter :authenticate_client_with_token!
	swagger_controller :clients, "Management of a client account"
	swagger_api :update do
		summary "Update the callback url of a client"
		param :path, :id, :integer, :required, "The id of the client"
		param :form, 'client[event_base_url]', :string, :required, "The new url"
	end

	def update
		current_client.update_attributes client_params
		render text: "OK"
	end

	private
	def client_params
		params.require(:client).permit(:event_base_url)
	end
end
