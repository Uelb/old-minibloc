class PhonesController < ApplicationController
	# swagger_controller :phones, "Add a new phone"

	# swagger_api :create do 
	# 	summary "Connect a phone to the system"
	# 	param :form, 'phone[number]', :string, :required, "The phone number"
	# end

	before_filter :authenticate!, only: :index

	def create
		@p = Phone.where(phone_params).first
		if @p
			@p.last_ping_date = Time.now
			@p.save
		else
			@p = Phone.create phone_params
		end
		render :json => @p
	end

	def index
		if current_client
			@phones = current_client.phones
		else
			render nothing: :true, status: 401
		end
	end

	private
	def phone_params
		params.require(:phone).permit(:number, :last_ping_date)
	end
end
