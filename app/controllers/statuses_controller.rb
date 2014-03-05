class StatusesController < ApplicationController
	before_filter :authenticate!
	swagger_controller :statuses, "Statuses management"
	swagger_api :show do
		summary "Retrieve the description of a status code"
		param :path, :id, :integer, :required, "The error/status code of the message"
		param :query, :token, :string, :optional, "The token of the phone doing the request" 
	end
	def show
		@status = Status.where(id: params[:id]).first
		render json: @status
	end
end
