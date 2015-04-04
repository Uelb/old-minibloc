class StatusesController < ApplicationController
	before_filter :authenticate!
	layout "macadmin"

	def show
		@status = Status.where(id: params[:id]).first
		render json: @status
	end

	def index
		@statuses = Status.all
	end
end
