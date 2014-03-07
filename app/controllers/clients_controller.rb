class ClientsController < ApplicationController
	before_filter :authenticate!, only: :update
	before_filter :authenticate_client!, only: [:show, :edit]
	# swagger_controller :clients, "Management of a client account"
	# swagger_api :update do
	# 	summary "Update the callback url of a client"
	# 	param :path, :id, :integer, :required, "The id of the client"
	# 	param :form, 'client[event_base_url]', :string, :required, "The new url"
	# end

	def show
		@client = current_client
	end

	def update
		current_client.update_attributes client_params
		if params[:api_key]
			render text: "OK"
		end
		redirect_to client_path(current_client)
	end

	def edit
		@client = current_client
	end

	private
	def client_params
		params.require(:client).permit(:name, :email, :event_base_url)
	end
end
