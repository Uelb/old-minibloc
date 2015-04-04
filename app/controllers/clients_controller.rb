class ClientsController < ApplicationController
	before_filter :authenticate!, only: :update
	before_filter :authenticate_client!, only: [:show, :edit]

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
