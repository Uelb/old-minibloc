class PhonesController < ApplicationController
	# swagger_controller :phones, "Add a new phone"

	# swagger_api :create do 
	# 	summary "Connect a phone to the system"
	# 	param :form, 'phone[number]', :string, :required, "The phone number"
	# end

	before_filter :authenticate!, only: :index
	before_filter :authenticate_client!, only: :update

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

	def new
		@phone = Phone.new
	end	

	def activate
		@phone = Phone.where(phone_update_params).first
		if @phone
			@phone.client = current_client
			@phone.save
		end
	end

	def resend_activation_code
		@phone = Phone.where(number: phone_code_params).first
	end

	private
	def phone_params
		params.require(:phone).permit(:number, :last_ping_date)
	end

	def phone_update_params
		params.require(:phone).permit(:activation_code, :number)
	end

	def phone_code_params
		params.require(:phone).permit(:number)
	end
end
