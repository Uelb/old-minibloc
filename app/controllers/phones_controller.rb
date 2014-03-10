class PhonesController < ApplicationController
	# swagger_controller :phones, "Add a new phone"

	# swagger_api :create do 
	# 	summary "Connect a phone to the system"
	# 	param :form, 'phone[number]', :string, :required, "The phone number"
	# end

	before_filter :authenticate!, only: :index
	before_filter :authenticate_client!, only: [:update, :use, :unuse, :activate]
	layout 'macadmin'

	def create
		@p = Phone.where(phone_params).first
		if @p
			@p.save!
		else
			@p = Phone.create phone_params
		end
		render :json => @p
	end

	def index
		if current_client
			@all_phones = current_client.phones
			@used_phones = current_client.used_phones
			@not_used_phones = @all_phones - @used_phones
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
			@phone.save!
		end
		redirect_to phones_path and return 
	end

	def resend_activation_code
		@phone = Phone.where(number: phone_code_params).first
	end

	def use
		@phone = Phone.where(id: params[:id]).first
		current_client.used_phones << @phone
		redirect_to phones_path and return 
	end

	def unuse
		@phone = Phone.where(id: params[:id]).first
		current_client.used_phones.delete(@phone)
		redirect_to phones_path and return 
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
